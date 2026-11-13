import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/constante/app_colors.dart';
import 'package:grace_church/core/injetction/injection_container.dart';
import 'package:grace_church/feature/home/presentation/widget/chart_whithe_grace.dart';
import 'package:grace_church/core/navigation/shara_router.dart';
import 'package:grace_church/feature/auth/domaine/usecase/surveiller_utilisateur_usecase.dart';
import 'package:grace_church/feature/home/domaine/usecase/create_task_from_voice.dart';
import 'package:grace_church/feature/home/domaine/usecase/shara_navigation_usecase.dart';
import 'package:grace_church/feature/home/presentation/bloc/voice_task.dart';
import 'package:grace_church/feature/taches/domaine/usecase/get_task_list_usecase.dart';
import 'package:grace_church/feature/taches/presentation/bloc/get_task/event/task_event.dart';
import 'package:grace_church/feature/taches/presentation/bloc/get_task/get_list_bloc.dart';
import 'package:record/record.dart';

/// ── Racine de l'application ─────────────────────────────────────────────────
///
/// Fournit les blocs globaux + le thème + le routeur go_router.
/// Toute la navigation passe par [SharaRouter] / [SharaNav]
/// (voir `SHARA_ROUTES.md`).
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
          create: (context) => GetListBloc(
            getTaskListUseCase: getIt<GetTaskListUseCase>(),
            surveillerUtilisateurUseCase: getIt<SurveillerUtilisateurUseCase>(),
          )..add(TaskSectionEvent.fetch(null)),
        ),
        BlocProvider(
          create: (context) => SharaNavigationBloc(
            interact: getIt<SharaInteractUsecase>(),
            recorder: AudioRecorder(),
            tts: FlutterTts(),
          ),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light().copyWith(
              textTheme: GoogleFonts.robotoTextTheme(
                Theme.of(context).textTheme,
              ),
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.black),
            ),
            routerConfig: SharaRouter.i,
          );
        },
      ),
    );
  }
}
