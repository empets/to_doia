import 'dart:developer';

import 'package:injectable/injectable.dart';

import 'package:grace_church/core/alarme_notification/domaine/entities/alarme_entite.dart';
import 'package:grace_church/core/alarme_notification/domaine/repositorie/alarme_repository.dart';
import 'package:grace_church/core/injetction/injection_container.dart';
import 'package:grace_church/core/constante/constantes.dart';

/// ── Coordination tâches ↔ alarmes/notifications ─────────────────────────────
///
/// Chaque fois qu'une tâche est **validée** (API call réussi via
/// `FormTastBloc`), [programmer] crée l'alarme + notification locale à la
/// date/heure de la tâche. L'alarme est persistée par le module
/// alarme_notification et **re-programmée automatiquement après un
/// redémarrage du téléphone** (voir [AlarmePersistanceService]).
///
/// Cycle de vie :
/// - création / validation          → programmer (alarme + notification)
/// - modification date/heure        → re-programmer (même id → remplace)
/// - suppression / terminée / annulée → annuler
/// - redémarrage du téléphone       → restauré par le module alarme
///
/// Ne programme JAMAIS si l'heure est déjà passée (pas de déclenchement
/// fantôme) et jamais sans enregistrement réussi (gardé par l'appelant).
@lazySingleton
class TaskReminderManager {
  TaskReminderManager(this._repository);

  final AlarmeRepository _repository;

  /// Payload de notification tapé (deep link côté [AlarmeNotificationService]).
  static const String _payloadType = 'task_reminder';

  // ── API ────────────────────────────────────────────────────────────────────

  /// Programme (ou re-programme) l'alarme + notification d'une tâche.
  ///
  /// À appeler UNIQUEMENT après le succès de l'enregistrement de la tâche.
  Future<void> programmer(String taskId, TaskReminderInfos infos) async {
    final dateHeure = parseDateHeure(infos.date, infos.time);
    if (dateHeure == null) {
      log('TaskReminderManager : date "${infos.date}" / heure '
          '"${infos.time}" non parsable → pas d\'alarme');
      return;
    }
    if (!dateHeure.isAfter(DateTime.now())) {
      log('TaskReminderManager : échéance passée, pas d\'alarme '
          '($dateHeure)');
      return;
    }

    final taskKey = _taskKey(taskId, infos);
    final alarme = AlarmeEntite(
      id: reminderIdFor(taskKey),
      titre: 'Rappel de tâche !',
      corps: 'Il est temps de commencer : ${infos.title}',
      dateHeure: dateHeure,
      // Tâche récurrente → répétition chaque semaine le même jour.
      joursDeRepetition: infos.recurring
          ? <int, bool>{dateHeure.weekday: true}
          : const <int, bool>{},
      channelId: AppCanauxAlarme.rappel,
      payload: {
        _payloadType: 'true',
        'taskId': taskId.isNotEmpty ? taskId : taskKey,
        'title': infos.title,
      },
    );

    final response = await _repository.modifier(alarme);
    response.fold(
      (failure) => log('TaskReminderManager.programmer échec : '
          '${failure.message}'),
      (_) => log(
        'TaskReminderManager : alarme #${alarme.id} programmée — '
        '${infos.title} @ $dateHeure',
      ),
    );
  }

  /// Annule l'alarme + notification d'une tâche
  /// (suppression, terminée, annulée).
  Future<void> annuler(String taskId, {TaskReminderInfos? infos}) async {
    if (taskId.trim().isEmpty && infos == null) return;
    final key = _taskKey(taskId, infos);
    final response = await _repository.supprimer(reminderIdFor(key));
    response.fold(
      (failure) => log('TaskReminderManager.annuler échec : ${failure.message}'),
      (_) => log('TaskReminderManager : alarme annulée pour "$key"'),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  /// Clé stable de la tâche : l'id métier s'il existe, sinon un hash
  /// titre+date+heure (tâche fraîchement créée dont l'id n'est pas
  /// encore connu de l'app).
  String _taskKey(String taskId, TaskReminderInfos? infos) {
    if (taskId.trim().isNotEmpty) return taskId.trim();
    if (infos != null) {
      return '${infos.title}|${infos.date}|${infos.time}';
    }
    return '';
  }

/// Identifiant 32 bits stable (contrainte Android/iOS) dérivé de la clé.
  static int reminderIdFor(String key) {
    var k = key.hashCode;
    return (k & 0x7FFFFFFF);
  }

  /// Parse `date` ("YYYY-MM-DD" en priorité, sinon "DD/MM/YYYY")
  /// + `time` ("HH:mm") → DateTime local.
  /// Retourne `null` si non parsable.
  static DateTime? parseDateHeure(String date, String time) {
    final d = date.trim();
    final t = time.trim();
    if (d.isEmpty || t.isEmpty) return null;

    RegExpMatch? m;
    int? day, month, year;
    if ((m = RegExp(r'^(\d{4})-(\d{1,2})-(\d{1,2})$').firstMatch(d)) != null) {
      year = int.parse(m!.group(1)!);
      month = int.parse(m.group(2)!);
      day = int.parse(m.group(3)!);
    } else if ((m =
            RegExp(r'^(\d{1,2})[/\-.](\d{1,2})[/\-.](\d{4})$').firstMatch(d)) !=
        null) {
      day = int.parse(m!.group(1)!);
      month = int.parse(m.group(2)!);
      year = int.parse(m.group(3)!);
    } else {
      return null;
    }

    final tm = RegExp(r'^(\d{1,2})[:hH](\d{1,2})$').firstMatch(t);
    if (tm == null) return null;
    final hour = int.parse(tm.group(1)!);
    final minute = int.parse(tm.group(2)!);

    try {
      return DateTime(year!, month!, day!, hour, minute);
    } catch (_) {
      return null;
    }
  }
}

/// Informations minimales pour programmer un rappel de tâche.
class TaskReminderInfos {
  const TaskReminderInfos({
    required this.title,
    required this.date,
    required this.time,
    this.recurring = false,
  });

  final String title;
  final String date;
  final String time;
  final bool recurring;
}

/// Extension d'accès pratique au manager via l'injection.
TaskReminderManager get taskReminderManager => getIt<TaskReminderManager>();

/// Référence au statuts de tâche (utilisé par les blocs qui branchent
/// le manager) — évite un import direct de constantes dans les usecases.
// const String taskStatusTerminer = c.TypeTaskStatus.TERMINER;
// const String taskStatusAnnuler = c.TypeTaskStatus.ANNULER;
// const String taskStatusSupprimer = c.TypeTaskStatus.SUPPRIMER;
