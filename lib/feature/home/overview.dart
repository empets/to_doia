import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/injetction/injection_container.dart';
import 'package:grace_church/core/models/task.dart';
import 'package:grace_church/core/persmission/permission_screen.dart';
import 'package:grace_church/core/succes_screen/success_screen.dart';
import 'package:grace_church/core/transcription/transcription_screen.dart';
import 'package:grace_church/core/voice/voice_listening.dart';
import 'package:grace_church/feature/home/domaine/usecase/create_task_from_voice.dart';
import 'package:grace_church/feature/home/presentation/bloc/voice_task.dart';
import 'package:grace_church/feature/home/presentation/page/home_screen.dart';
import 'package:grace_church/feature/onboarding/splash_screen.dart';
import 'package:grace_church/feature/setting/setting_screen.dart';
import 'package:grace_church/feature/setting/sub_setting_screen.dart';
import 'package:grace_church/feature/taches/domaine/usecase/get_task_list_usecase.dart';
import 'package:grace_church/feature/taches/presentation/bloc/get_task/event/task_event.dart';
import 'package:grace_church/feature/taches/presentation/bloc/get_task/get_list_bloc.dart';
import 'package:grace_church/feature/taches/presentation/pages/manual_create_screen.dart';
import 'package:grace_church/feature/taches/presentation/pages/tasks_screen.dart';

class SmartReminderApp extends StatelessWidget {
  const SmartReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VoiceTaskCubit(
            createTask: getIt<CreateTaskFromVoiceUseCase>(),
            recorder: VoiceRecorder(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              GetListBloc(getTaskListUseCase: getIt<GetTaskListUseCase>())
                ..add(TaskSectionEvent.fetch(null)),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light().copyWith(
              textTheme: GoogleFonts.robotoTextTheme(
                Theme.of(context).textTheme,
              ),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
            ),
            home: child, // 👈 IMPORTANT
          );
        },
        child: const AppShell(),
      ),
    );
  }
}

// ─── Machine d'état principale ─────────────────────────────────────────────────
enum AppScreen {
  splash,
  permissions,
  home,
  listening,
  transcription,
  analyzing,
  confirmation,
  success,
  tasks,
  manualCreate,
  settings,
  settingsAppearance,
  settingsLanguage,
  settingsNotifications,
  settingsVoice,
  settingsData,
  settingsAbout,
  settingsHelp,
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  AppScreen _screen = AppScreen.splash;
  int _navIndex = 0; // 0 = home, 1 = tasks, 2 = settings

  // Données vocales temporaires
  String _transcript = '';
  Task? _pendingTask;

  // Tâches
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Réunion avec l\'équipe',
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
  ];

  // Paramètres
  bool _notifOn = true;
  bool _soundOn = true;
  bool _vibOn = true;
  bool _confirmCreate = true;
  String _theme = 'system';
  String _appLang = 'Français';
  String _voiceLang = 'Français';
  String _lateReminder = 'Notifier immédiatement';
  String _reminderBefore = '5 minutes';

  // ── Navigation ──────────────────────────────────────────────────────────────
  void _go(AppScreen s) => setState(() => _screen = s);

  void _goNav(int i) => setState(() {
    _navIndex = i;
    _screen = [AppScreen.home, AppScreen.tasks, AppScreen.settings][i];
  });

  // ── Gestion tâches ──────────────────────────────────────────────────────────
  void _toggleTask(String id) => setState(() {
    final t = _tasks.firstWhere((t) => t.id == id);
    t.done = !t.done;
  });

  void _deleteTask(String id) =>
      setState(() => _tasks.removeWhere((t) => t.id == id));

  void _addTask(Task t) {
    setState(() => _tasks.add(t));
    _go(AppScreen.success);
    _pendingTask = t;
  }

  void _restartTask(Task t) => setState(() => t.done = false);

  // ── Flux vocal simulé ───────────────────────────────────────────────────────
  void _startListening() {
    _go(AppScreen.listening);
    // Simulation : arrêt auto après 3 secondes
    Future.delayed(const Duration(seconds: 3), () {
      if (_screen == AppScreen.listening && mounted) _stopListening();
    });
  }

  void _stopListening() {
    _transcript = 'Demain à 10h, rappelle-moi d\'appeler Jean.';
    _go(AppScreen.transcription);
  }

  void _confirmTranscript() {
    _go(AppScreen.analyzing);
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (mounted) {
        _pendingTask = Task(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: 'Appeler Jean',
          date: 'Demain',
          time: '10:00',
        );
        _go(AppScreen.confirmation);
      }
    });
  }

  void _confirmTask() {
    if (_pendingTask != null) {
      setState(() => _tasks.add(_pendingTask!));
    }
    _go(AppScreen.success);
  }

  // ── Build ───────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final bool showNav = [
      AppScreen.home,
      AppScreen.tasks,
      AppScreen.settings,
    ].contains(_screen);

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 260),
        transitionBuilder: (child, anim) => FadeTransition(
          opacity: anim,
          child: SlideTransition(
            position: Tween(
              begin: const Offset(0.03, 0),
              end: Offset.zero,
            ).animate(anim),
            child: child,
          ),
        ),
        child: KeyedSubtree(key: ValueKey(_screen), child: _buildScreen()),
      ),
      bottomNavigationBar: showNav ? _buildNav() : null,
    );
  }

  Widget _buildScreen() {
    switch (_screen) {
      // ── Démarrage ──────────────────────────────────────────────────────────
      case AppScreen.splash:
        return SplashScreen(onFinish: () => _go(AppScreen.permissions));

      case AppScreen.permissions:
        return PermissionsScreen(onDone: () => _go(AppScreen.home));

      // ── Principal ──────────────────────────────────────────────────────────
      case AppScreen.home:
        return HomeScreen(
          tasks: _tasks,
          onMicTap: _startListening,
          onViewTasks: () => _goNav(1),
          onNotif: () {},
        );

      // ── Flux vocal ─────────────────────────────────────────────────────────
      case AppScreen.listening:
        return VoiceListeningScreen(
          actionType:' TypeCreateTaskOrUpdate.CREATE_TASK,'
          // onStop: _stopListening,
          // onCancel: () => _go(AppScreen.home),
        );

      case AppScreen.transcription:
        return TranscriptionScreen(
          // transcript: _transcript,
          // onConfirm: _confirmTranscript,
          // onRetry: _startListening,
          // onCancel: () => _go(AppScreen.home),
        );

      // case AppScreen.analyzing:
      //   return const AIAnalyzingScreen();

      case AppScreen.confirmation:
        return SizedBox(); //ConfirmationScreen(
      // task: _pendingTask!,
      // onConfirm: _confirmTask,
      // onModify: () => _go(AppScreen.manualCreate),
      // onCancel: () => _go(AppScreen.home),
      //);

      case AppScreen.success:
        return SuccessScreen(
          // task: _pendingTask!,
          // onGoHome: () => _goNav(0),
          // onGoTasks: () => _goNav(1),
        );

      // ── Tâches ─────────────────────────────────────────────────────────────
      case AppScreen.tasks:
        return TasksScreen(
          tasks: _tasks,
          onToggle: _toggleTask,
          onDelete: _deleteTask,
          onRestart: _restartTask,
          onMicTap: _startListening,
          onAddManual: () => _go(AppScreen.manualCreate),
        );

      case AppScreen.manualCreate:
        return ManualCreateScreen(
          // onAdd: _addTask,
          // onBack: () => _go(AppScreen.tasks),
        );

      // ── Paramètres ─────────────────────────────────────────────────────────
      case AppScreen.settings:
        return SettingsScreen(
          onRoute: (r) => _go(_routeToScreen(r)),
          notifOn: _notifOn,
          onToggleNotif: (v) => setState(() => _notifOn = v),
          soundOn: _soundOn,
          onToggleSound: (v) => setState(() => _soundOn = v),
          vibOn: _vibOn,
          onToggleVib: (v) => setState(() => _vibOn = v),
          confirmCreate: _confirmCreate,
          onToggleConfirmCreate: (v) => setState(() => _confirmCreate = v),
        );

      case AppScreen.settingsAppearance:
        return _subScaffold(
          'Apparence',
          AppearanceScreen(
            initialTheme: _theme,
            onChanged: (v) => setState(() => _theme = v),
          ),
        );

      case AppScreen.settingsLanguage:
        return _subScaffold(
          'Langue',
          LanguageScreen(
            appLang: _appLang,
            voiceLang: _voiceLang,
            onAppLang: (v) => setState(() => _appLang = v),
            onVoiceLang: (v) => setState(() => _voiceLang = v),
          ),
        );

      case AppScreen.settingsNotifications:
        return _subScaffold(
          'Notifications',
          NotificationsSettingsScreen(
            notifOn: _notifOn,
            soundOn: _soundOn,
            vibOn: _vibOn,
            onNotif: (v) => setState(() => _notifOn = v),
            onSound: (v) => setState(() => _soundOn = v),
            onVib: (v) => setState(() => _vibOn = v),
            lateReminder: _lateReminder,
            reminderBefore: _reminderBefore,
            onLate: (v) => setState(() => _lateReminder = v),
            onBefore: (v) => setState(() => _reminderBefore = v),
          ),
        );

      case AppScreen.settingsVoice:
        return _subScaffold(
          'Voix et IA',
          VoiceAIScreen(
            confirmCreate: _confirmCreate,
            onConfirmCreate: (v) => setState(() => _confirmCreate = v),
          ),
        );

      case AppScreen.settingsData:
        return _subScaffold(
          'Données',
          DataScreen(
            tasks: _tasks,
            onDeleteAll: () => setState(() {
              _tasks.clear();
              _go(AppScreen.home);
            }),
          ),
        );

      case AppScreen.settingsAbout:
        return _subScaffold('À propos', const AboutScreen());

      case AppScreen.settingsHelp:
        return _subScaffold('Aide', const HelpScreen());
      case AppScreen.analyzing:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  // Enrobe un sous-écran de paramètres avec un bouton retour
  Widget _subScaffold(String title, Widget child) => Scaffold(
    backgroundColor: const Color(0xFFF4F6FB),
    appBar: AppBar(
      backgroundColor: const Color(0xFFF4F6FB),
      elevation: 0,
      leading: GestureDetector(
        onTap: () => _go(AppScreen.settings),
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.chevron_left_rounded,
            color: Color(0xFF6366F1),
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF1A1A2E),
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    body: child,
  );

  AppScreen _routeToScreen(String r) => switch (r) {
    'appearance' => AppScreen.settingsAppearance,
    'language' => AppScreen.settingsLanguage,
    'notifications' => AppScreen.settingsNotifications,
    'voice' => AppScreen.settingsVoice,
    'data' => AppScreen.settingsData,
    'about' => AppScreen.settingsAbout,
    'help' => AppScreen.settingsHelp,
    _ => AppScreen.settings,
  };

  // ── Barre de navigation ─────────────────────────────────────────────────────
  Widget _buildNav() {
    const items = [
      (Icons.home_rounded, Icons.home_outlined, 'Accueil'),
      (Icons.task_alt_rounded, Icons.check_circle_outline, 'Tâches'),
      (Icons.settings_rounded, Icons.settings_outlined, 'Paramètres'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((e) {
              final active = _navIndex == e.key;
              return GestureDetector(
                onTap: () => _goNav(e.key),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 4,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        active ? e.value.$1 : e.value.$2,
                        color: active
                            ? const Color(0xFF6366F1)
                            : const Color(0xFF6B7280),
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        e.value.$3,
                        style: TextStyle(
                          color: active
                              ? const Color(0xFF6366F1)
                              : const Color(0xFF6B7280),
                          fontSize: 11,
                          fontWeight: active
                              ? FontWeight.w700
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
