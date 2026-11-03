import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grace_church/core/alarme_notification/presentation/pages/simulation_alarme_page.dart';
import 'package:grace_church/core/confirmation/confimation_screen.dart';
import 'package:grace_church/core/constante/app_colors.dart';
import 'package:grace_church/core/ia_analyse/ai_analyzing_screen.dart';
import 'package:grace_church/core/injetction/injection_container.dart';
import 'package:grace_church/core/navigation/app_flow_controller.dart';
import 'package:grace_church/core/navigation/shara_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_church/core/constante/constantes.dart';
import 'package:grace_church/core/persmission/permission_screen.dart';
import 'package:grace_church/core/succes_screen/success_screen.dart';
import 'package:grace_church/core/transcription/transcription_screen.dart';
import 'package:grace_church/core/voice/voice_listening.dart';
import 'package:grace_church/feature/home/domaine/usecase/create_task_usecase.dart';
import 'package:grace_church/feature/home/domaine/usecase/update_task_from_usercase.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/create_or_update_task_bloc.dart';
import 'package:grace_church/feature/home/presentation/page/home_screen.dart';
import 'package:grace_church/feature/onboarding/splash_screen.dart';
import 'package:grace_church/feature/setting/setting_screen.dart';
import 'package:grace_church/feature/setting/sub_setting_screen.dart';
import 'package:grace_church/feature/taches/presentation/pages/manual_create_screen.dart';
import 'package:grace_church/feature/taches/presentation/pages/tasks_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'shara_nav.dart';
import 'shara_nav_shell.dart';

/// ── Routeur global (go_router) ──────────────────────────────────────────────
///
/// Toute la navigation de l'app passe par son navigater :
/// la voix (Shara), la barre du bas, et les interactions des écrans
/// (`SharaNav` = accès statique sans BuildContext).
class SharaRouter {
  SharaRouter._();

  /// Clé du Navigator racine (getIt-like accordor : `SharaRouter.i`).
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Accès au [GoRouter] (ex. `SharaRouter.i.push(...)`).
  static final GoRouter i = _build();

  // ── Contrôleur d'état ──────────────────────────────────────────────────────
  static AppFlowController get flow => AppFlowController.instance;

  // ── Helpers de construction des bran immagini ─────────────────────────────

  /// Écran Accueil reconstruit selon l'état du contrôleur.
  static Widget _homeBranch() => ValueListenableBuilder(
    valueListenable: flow.version,
    builder: (_, _, _) => HomeScreen(
      tasks: flow.tasks.value,
      onMicTap: () => SharaNav.startVoice(),
      onViewTasks: () => SharaNav.navigate('tasks'),
      onNavigate: SharaNav.navigate,
      onCreateTask: SharaNav.createTaskFromVoice,
      onNotif: () => SharaNav.navigate('simulation_alarme'),
    ),
  );

  static Widget _tasksBranch() => TasksScreen(
    onNavigate: SharaNav.navigate,
    onCreateTask: SharaNav.createTaskFromVoice,
  );

  static Widget _settingsBranch() => ValueListenableBuilder(
    valueListenable: flow.version,
    builder: (_, _, _) => SettingsScreen(
      onRoute: (r) => SharaNav.navigate(r),
      onNavigate: SharaNav.navigate,
      onCreateTask: SharaNav.createTaskFromVoice,
      notifOn: flow.notifOn,
      onToggleNotif: (v) => flow.notif = v,
      soundOn: flow.soundOn,
      onToggleSound: (v) => flow.sound = v,
      vibOn: flow.vibOn,
      onToggleVib: (v) => flow.vib = v,
      confirmCreate: flow.confirmCreate,
      onToggleConfirmCreate: (v) => flow.confirmOnCreate = v,
    ),
  );

  // ── Wrappers flux tâche ────────────────────────────────────────────────────

  static Widget _formBloc(Widget child) => BlocProvider<FormTastBloc>(
    create: (context) => FormTastBloc(
      createTaskUseCase: getIt<CreateTaskUseCase>(),
      updateTaskUseCase: getIt<UpdateTaskUseCase>(),
    ),
    child: child,
  );

  /// Si aucune tâche en attente : alerte + accueil.
  static Widget _guardedTaskFlow(Widget child) {
    final task = flow.pendingTask;
    if (task == null) {
      return _missingTaskFallback(child);
    }
    return child;
  }

  static Widget _missingTaskFallback(Widget child) {
    return Builder(
      builder: (context) {
        final ctx = navigatorKey.currentContext!;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (flow.pendingTask == null) {
            SharaNav.showInfo(
              ctx,
              "Aucune tâche en attente. Dis « Shara, crée une tâche… » d'abord.",
            );
          }
        });
        return child;
      },
    );
  }

  // ── Définition du routeur ──────────────────────────────────────────────────
  static GoRouter _build() {
    return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: SharaRoute.splash,
      routes: [
        // ── Démarrage ─────────────────────────────────────────────────────────
        GoRoute(
          path: SharaRoute.splash,
          builder: (context, state) =>
              SplashScreen(onFinish: () => context.go(SharaRoute.permissions)),
        ),
        GoRoute(
          path: SharaRoute.permissions,
          builder: (context, state) =>
              PermissionsScreen(onDone: () => context.go(SharaRoute.home)),
        ),

        // ── Onglets avec barre du bas ─────────────────────────────────────────
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              SharaNavShell(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(routes: [
              GoRoute(
                path: SharaRoute.home,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: _HomeBranchWidget()),
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: SharaRoute.tasks,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: _TasksBranchWidget()),
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: SharaRoute.settings,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: _SettingsBranchWidget()),
              ),
            ]),
          ],
        ),

        // ── Flux tâche ────────────────────────────────────────────────────────
        GoRoute(
          path: SharaRoute.manualCreate,
          builder: (context, state) {
            final args =
                state.extra is ManualCreateArgs
                    ? state.extra! as ManualCreateArgs
                    : ManualCreateArgs();
            // Modification via voix ? on lit la tâche en attente du flux
            final task = args.task ?? (args.isPope ? null : flow.pendingTask);
            return _formBloc(
              ManualCreateScreen(
                task: task,
                actionType: args.isPope
                    ? args.actionType
                    : args.task != null
                    ? TypeCreateTaskOrUpdate.UPDATE_TASK
                    : flow.pendingActionType,
                isPope: args.isPope,
              ),
            );
          },
        ),
        GoRoute(
          path: SharaRoute.listening,
          builder: (context, state) =>
              VoiceListeningScreen(actionType: flow.voiceActionType),
        ),
        GoRoute(
          path: SharaRoute.transcription,
          builder: (context, state) => const TranscriptionScreen(),
        ),
        GoRoute(
          path: SharaRoute.analyzing,
          builder: (context, state) => _guardedTaskFlow(
            AIAnalyzingScreen(
              task: flow.pendingTask!,
              actionType: flow.pendingActionType,
              onDone: () => SharaNav.go(SharaRoute.confirmation),
            ),
          ),
        ),
        GoRoute(
          path: SharaRoute.confirmation,
          builder: (context, state) => _guardedTaskFlow(
            _formBloc(
              ConfirmationScreen(
                task: flow.pendingTask!,
                actionType: flow.pendingActionType,
                onSuccess: SharaNav.taskConfirmed,
                onModify: () => SharaNav.modifyTask(flow.pendingTask!),
                onCancel: () => SharaNav.navigate('home'),
              ),
            ),
          ),
        ),
        GoRoute(
          path: SharaRoute.success,
          builder: (context, state) =>
              SuccessScreen(task: flow.takePendingTask),
        ),

        // ── Divers ────────────────────────────────────────────────────────────
        GoRoute(
          path: SharaRoute.simulationAlarme,
          builder: (context, state) => SimulationAlarmePageWithBack(),
        ),

        // ── Sous-écrans Paramètres ────────────────────────────────────────────
        GoRoute(
          path: SharaRoute.settingsAppearance,
          builder: (context, state) => ValueListenableBuilder(
            valueListenable: flow.version,
            builder: (_, _, _) => SubSettingScaffold(
              title: 'Apparence',
              child: AppearanceScreen(
                initialTheme: flow.theme,
                onChanged: (v) => flow.appTheme = v,
              ),
            ),
          ),
        ),
        GoRoute(
          path: SharaRoute.settingsLanguage,
          builder: (context, state) => ValueListenableBuilder(
            valueListenable: flow.version,
            builder: (_, _, _) => SubSettingScaffold(
              title: 'Langue',
              child: LanguageScreen(
                appLang: flow.appLang,
                voiceLang: flow.voiceLang,
                onAppLang: (v) => flow.setAppLang = v,
                onVoiceLang: (v) => flow.setVoiceLang = v,
              ),
            ),
          ),
        ),
        GoRoute(
          path: SharaRoute.settingsNotifications,
          builder: (context, state) => ValueListenableBuilder(
            valueListenable: flow.version,
            builder: (_, _, _) => SubSettingScaffold(
              title: 'Notifications',
              child: NotificationsSettingsScreen(
                notifOn: flow.notifOn,
                soundOn: flow.soundOn,
                vibOn: flow.vibOn,
                onNotif: (v) => flow.notif = v,
                onSound: (v) => flow.sound = v,
                onVib: (v) => flow.vib = v,
                lateReminder: flow.lateReminder,
                reminderBefore: flow.reminderBefore,
                onLate: (v) => flow.lateReminderMode = v,
                onBefore: (v) => flow.reminderBeforeMode = v,
              ),
            ),
          ),
        ),
        GoRoute(
          path: SharaRoute.settingsVoice,
          builder: (context, state) => ValueListenableBuilder(
            valueListenable: flow.version,
            builder: (_, _, _) => SubSettingScaffold(
              title: 'Voix et IA',
              child: VoiceAIScreen(
                confirmCreate: flow.confirmCreate,
                onConfirmCreate: (v) => flow.confirmOnCreate = v,
              ),
            ),
          ),
        ),
        GoRoute(
          path: SharaRoute.settingsData,
          builder: (context, state) => ValueListenableBuilder(
            valueListenable: flow.version,
            builder: (_, _, _) => SubSettingScaffold(
              title: 'Données',
              child: DataScreen(
                tasks: flow.tasks.value,
                onDeleteAll: () {
                  AppFlowController.instance.clearAllTasks();
                  SharaNav.go(SharaRoute.home);
                },
              ),
            ),
          ),
        ),
        GoRoute(
          path: SharaRoute.settingsAbout,
          builder: (context, state) =>
              SubSettingScaffold(title: 'À propos', child: const AboutScreen()),
        ),
        GoRoute(
          path: SharaRoute.settingsHelp,
          builder: (context, state) => SubSettingScaffold(
            title: 'Aide',
            child: const HelpScreen(),
          ),
        ),
      ],
    );
  }
}

// ── Wrappers construits dans le builder (rebuild sur version) ────────────────

class _HomeBranchWidget extends StatelessWidget {
  const _HomeBranchWidget();

  @override
  Widget build(BuildContext context) => SharaRouter._homeBranch();
}

class _TasksBranchWidget extends StatelessWidget {
  const _TasksBranchWidget();

  @override
  Widget build(BuildContext context) => SharaRouter._tasksBranch();
}

class _SettingsBranchWidget extends StatelessWidget {
  const _SettingsBranchWidget();

  @override
  Widget build(BuildContext context) => SharaRouter._settingsBranch();
}

/// Simulation alarme — enrobage avec un bouton de retour vers l'accueil.
class SimulationAlarmePageWithBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.go(SharaRoute.home),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.chevron_left_rounded,
              color: AppColors.primary,
            ),
          ),
        ),
        title: Text(
          'Simulation — Alarmes & Notifications',
          style: GoogleFonts.roboto(
            color: AppColors.ink,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: const SimulationAlarmePage(),
    );
  }
}

// ignore: unused_element — conservé pour l'API future du routeur
extension _RouterExtras on SharaRouter {}
