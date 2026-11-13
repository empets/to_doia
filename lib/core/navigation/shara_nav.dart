import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grace_church/core/alert/app_alerte.dart';
import 'package:grace_church/core/alarme_notification/domaine/task_reminder_manager.dart';
import 'package:grace_church/core/constante/constantes.dart';
import 'package:grace_church/core/injetction/injection_container.dart';
import 'package:grace_church/core/models/task.dart';
import 'package:grace_church/core/navigation/app_flow_controller.dart';
import 'package:grace_church/core/navigation/shara_route.dart';
import 'package:grace_church/core/navigation/shara_router.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/taches/presentation/bloc/get_task/event/task_event.dart';
import 'package:grace_church/feature/taches/presentation/bloc/get_task/get_list_bloc.dart';

/// ── Façade de navigation du projet ──────────────────────────────────────────
///
/// Point de passage OBLIGATOIRE pour toute navigation :
/// - la voix (Shara),
/// - la barre du bas,
/// - les boutons des écrans.
///
/// Toutes les destinations passent par [navigate] — le même registre
/// (voir `SHARA_ROUTES.md`), pour que la voix ne fasse rien que l'UI
/// ne fasse aussi, et inversement. Aucun écran ne doit utiliser
/// `Navigator.push(MaterialPageRoute(...))` pour une page pleine
/// (réservé aux modales/dialogues avec valeur de retour).
class SharaNav {
  SharaNav._();

  // ── Helpers d'accès ────────────────────────────────────────────────────────
  static BuildContext get _ctx {
    final c = SharaRouter.navigatorKey.currentContext;
    if (c == null) throw StateError('NavigatorKey non montée');
    return c;
  }

  // ── API principale ─────────────────────────────────────────────────────────

  /// Navigation par destination (vocabulaire Shara) :
  /// `home`, `tasks`, `settings`, `create_task`, `voice`, …
  ///
  /// Utilisée par la voix ET par l'UI.
  static void navigate(String destination) {
    final target = destination
        .trim()
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll('-', '_');

    final path = SharaRoute.pathForDestination[target];
    if (path == null) {
      log('SharaNav : destination inconnue "$destination"');
      AppAlert.showInfo(
        _ctx,
        'Destination Shara inconnue : $target',
      );
      return;
    }
    go(path);
  }

  /// Navigation directe par chemin (rare — préférer [navigate]).
  static void go(String path) {
    // So security : les flux tâche nécessitent une tâche en attente.
    final needTask = path == SharaRoute.analyzing ||
        path == SharaRoute.confirmation ||
        path == SharaRoute.success;
    if (needTask && AppFlowController.instance.pendingTask == null) {
      AppAlert.showInfo(
        _ctx,
        "Aucune tâche en attente. Dis « Shara, crée une tâche… » d'abord.",
      );
      return;
    }
    log('SharaNav.go → $path');
    SharaRouter.i.go(path);
  }

  /// ── Flux vocal ────────────────────────────────────────────────────────────
  ///
  /// Ouvre l'écran d'écoute avec le type d'action (CREATE / UPDATE…).
  static void startVoice([
    String actionType = TypeCreateTaskOrUpdate.CREATE_TASK,
  ]) {
    AppFlowController.instance.voiceActionType = actionType;
    SharaRouter.i.go(SharaRoute.listening);
  }

  /// ── Création de tâche via la voix ────────────────────────────────────────
  ///
  /// Reçoit la tâche complète préparée par Shara — même flux que
  /// VoiceListeningScreen : analyse IA →ConfirmationScreen.
  static void createTaskFromVoice(TaskResponse task) {
    AppFlowController.instance.prepareCreate(task);
    SharaRouter.i.go(SharaRoute.analyzing);
  }

  /// Alias explicite côté SharaAI.
  static void confirmTask(TaskResponse task) => createTaskFromVoice(task);

  /// ── Modification de tâche ────────────────────────────────────────────────
  static void modifyTask(TaskResponse task) {
    AppFlowController.instance.prepareModify(task);
    SharaRouter.i.push(
      SharaRoute.manualCreate,
      extra: ManualCreateArgs(task: task, isPope: false),
    );
  }

  /// Ouvre le formulaire manuel vierge ou avec une tâche pré-remplie.
  static void openManualForm([TaskResponse? task]) {
    if (task != null) {
      modifyTask(task);
      return;
    }
    AppFlowController.instance.clearPending();
    SharaRouter.i.push(
      SharaRoute.manualCreate,
      extra: const ManualCreateArgs(),
    );
  }

  /// ── Tâche confirmée (bouton « Confirmer » de ConfirmationScreen) ────────
  ///
  /// Appelé après succès de création, que ce soit par le formulaire manuel ou
  /// par la voix (Shara). Crée la notification locale si la tâche est bien
  /// enregistrée dans Firebase, puis bascule sur l'écran de succès.
  static Future<void> taskConfirmed() async {
    final t = AppFlowController.instance.pendingTask;
    if (t != null) {
      AppFlowController.instance.addLocal(
        Task(
          id: t.taskId.isEmpty
              ? DateTime.now().millisecondsSinceEpoch.toString()
              : t.taskId,
          title: t.title,
          date: t.date.isNotEmpty ? t.date : "Aujourd'hui",
          time: t.time.isNotEmpty ? t.time : '09:00',
          recurrence: t.recurring ? 'Quotidien' : '',
        ),
      );
      // Synchronise l'alarme/notification locale (création ou annulation selon
      // le statut). Peu importe le flow : vocal ou manuel.
      _syncRappel(t);
    }
    // Rafraîchit la liste de tâches bloquée par l'API.
    try {
      final bctx = SharaRouter.navigatorKey.currentContext;
      if (bctx != null) {
        bctx.read<GetListBloc>().add(TaskSectionEvent.fetch(null));
      }
    } catch (e) {
      log('SharaNav.taskConfirmed : GetListBloc indisponible ($e)');
    }
    // La création manuelle n'a pas de pendingTask (préparé uniquement par le
    // flux vocal). go() bloque sur /success quand pendingTask == null, donc on
    // navigue directement via le routeur.
    SharaRouter.i.go(SharaRoute.success);
  }

  /// Crée ou annule la notification locale pour une tâche confirmée.
  static void _syncRappel(TaskResponse t) {
    final statut = t.status.toUpperCase();
    final doitAnnuler =
        statut.contains(TypeTaskStatus.TERMINER) ||
        statut.contains(TypeTaskStatus.ANNULER) ||
        statut.contains(TypeTaskStatus.SUPPRIMER);

    final reminder = getIt<TaskReminderManager>();
    if (doitAnnuler) {
      reminder.annuler(t.taskId);
    } else {
      reminder.programmer(
        t.taskId,
        TaskReminderInfos(
          title: t.title,
          date: t.date,
          time: t.time,
          recurring: t.recurring,
        ),
      );
    }
  }

  /// ── Utilitaires ──────────────────────────────────────────────────────────
  static void showInfo(BuildContext context, String message) =>
      AppAlert.showInfo(context, message);
}
