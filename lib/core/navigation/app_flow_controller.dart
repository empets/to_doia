import 'package:flutter/material.dart';
import 'package:grace_church/core/constante/constantes.dart';
import 'package:grace_church/core/models/task.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';

/// Arguments du formulaire de création/modification de tâche.
///
/// Passé en `extra` du `/manual-create` via go_router.
class ManualCreateArgs {
  const ManualCreateArgs({
    this.task,
    this.actionType = TypeCreateTaskOrUpdate.CREATE_TASK,
    this.isPope = false,
  });

  final TaskResponse? task;
  final String actionType;
  final bool isPope;
}

/// ── Etat global de l'application (version go_router) ────────────────────────
///
/// Remplace la machine d'état interne de l'ancien `AppShell` :
/// - tâches (mode simulation),
/// - réglages (notifications, sons, thème, langues…),
/// - tâche en attente du flux création/confirmation,
/// - type d'action du flux vocal en cours.
///
/// Les écrans chargés par le routeur doivent être reconstruits quand
/// [version] (ou [tasks]) change : voir `AppStateListener`.
class AppFlowController {
  AppFlowController._();
  static final AppFlowController instance = AppFlowController._();

  // ── Tâches (simulation locale) ─────────────────────────────────────────────
  final ValueNotifier<List<Task>> tasks = ValueNotifier<List<Task>>([
    Task(
      id: '1',
      title: "Réunion avec l'équipe",
      date: "Aujourd'hui",
      time: '10:00',
      recurrence: 'Hebdomadaire',
    ),
    Task(
      id: '2',
      title: 'Appeler le médecin',
      date: "Aujourd'hui",
      time: '14:30',
    ),
    Task(
      id: '3',
      title: 'Préparer la présentation',
      date: 'Demain',
      time: '09:00',
    ),
    Task(
      id: '4',
      title: 'Course alimentaire',
      date: '25/10',
      time: '17:00',
      recurrence: 'Hebdomadaire',
    ),
    Task(
      id: '5',
      title: 'Sport',
      date: '25/10',
      time: '07:00',
      recurrence: 'Quotidien',
      done: true,
    ),
  ]);

  /// Incrémenté à chaque mutation de réglage — les écrans de réglages
  /// l'écoutent pour se reconstruire.
  final ValueNotifier<int> version = ValueNotifier<int>(0);

  // ── Réglages ───────────────────────────────────────────────────────────────
  bool notifOn = true;
  bool soundOn = true;
  bool vibOn = true;
  bool confirmCreate = true;
  String theme = 'system';
  String appLang = 'Français';
  String voiceLang = 'Français';
  String lateReminder = 'Notifier immédiatement';
  String reminderBefore = '5 minutes';

  // ── Flux tâche en attente (création Shara / vocal / confirmation) ─────────
  TaskResponse? get pendingTask => _pendingVoiceTask;
  TaskResponse? _pendingVoiceTask;
  String pendingActionType = TypeCreateTaskOrUpdate.CREATE_TASK;

  // ── Flux vocal en cours ────────────────────────────────────────────────────
  String voiceActionType = TypeCreateTaskOrUpdate.CREATE_TASK;

  // ── API ────────────────────────────────────────────────────────────────────

  /// Prépare une tâche pour le flux complet : analyse IA → confirmation.
  void prepareCreate(TaskResponse task) {
    _pendingVoiceTask = task;
    pendingActionType = TypeCreateTaskOrUpdate.CREATE_TASK;
  }

  /// Prépare une tâche existante pour modification (formulaire manuel).
  void prepareModify(TaskResponse task) {
    _pendingVoiceTask = task;
    pendingActionType = TypeCreateTaskOrUpdate.UPDATE_TASK;
  }

  TaskResponse? get takePendingTask => _pendingVoiceTask;

  void clearPending() => _pendingVoiceTask = null;

  /// Ajoute localement une tâche validée (mode simulation, la création
  /// réelle part via FormTastBloc → API).
  void addLocal(Task t) {
    tasks.value = [...tasks.value, t];
  }

  void _bump() => version.value++;

  // setters réglages
  set notif(bool v) {
    notifOn = v;
    _bump();
  }

  set sound(bool v) {
    soundOn = v;
    _bump();
  }

  set vib(bool v) {
    vibOn = v;
    _bump();
  }

  set confirmOnCreate(bool v) {
    confirmCreate = v;
    _bump();
  }

  set appTheme(String v) {
    theme = v;
    _bump();
  }

  set setAppLang(String v) {
    appLang = v;
    _bump();
  }

  set setVoiceLang(String v) {
    voiceLang = v;
    _bump();
  }

  set lateReminderMode(String v) {
    lateReminder = v;
    _bump();
  }

  set reminderBeforeMode(String v) {
    reminderBefore = v;
    _bump();
  }

  void clearAllTasks() {
    tasks.value = [];
    _bump();
  }
}
