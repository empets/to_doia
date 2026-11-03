import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grace_church/core/alert/app_alerte.dart';
import 'package:grace_church/core/constante/constantes.dart';
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
  static void taskConfirmed() {
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
    go(SharaRoute.success);
  }

  /// ── Utilitaires ──────────────────────────────────────────────────────────
  static void showInfo(BuildContext context, String message) =>
      AppAlert.showInfo(context, message);
}
