import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_church/feature/home/data/model/home_responses_models.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/home/presentation/widget/chart_whithe_grace.dart';

class SharaAI extends StatelessWidget {
  const SharaAI({
    super.key,
    this.onViewTasks,
    this.onNavigate,
    this.onCreateTask,
  });

  /// Rétro-compatibilité : simple callback vers la liste des tâches.
  final VoidCallback? onViewTasks;

  /// Navigation déléguée à la machine d'état de l'AppShell (overview).
  ///
  /// Reçoit la destination brute renvoyée par Shara (`tasks`, `home`,
  /// `settings`, …) et s'en charge de toutes les transitions — plus aucun
  /// `Navigator.push` direct depuis la barre.
  final void Function(String destination)? onNavigate;

  /// Création de tâche déléguée à l'AppShell :
  /// même flux que VoiceListeningScreen (analyse IA → confirmation).
  final void Function(TaskResponse task)? onCreateTask;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SharaNavigationBloc, SharaNavigationState>(
      listener: (context, state) {
        if (state is SharaNavigationSuccess) {
          final action = state.response.action;

          // 1) Création de tâche → shara prépare la tâche, l'AppShell
          //    enchaîne analyse IA puis écran de confirmation.
          if (action.isCreateTask && action.task != null) {
            if (onCreateTask != null) {
              onCreateTask!(TaskResponseModel.toDomain(action.task!));
            }
            return;
          }

          // 2) Navigation vers une destination connue de l'AppShell.
          final destination = action.destination?.trim().toLowerCase();
          if (destination == null || destination.isEmpty) return;

          if (onNavigate != null) {
            onNavigate!(destination);
          } else if (destination == 'tasks' || destination == 'mes_taches') {
            Future.delayed(Duration(seconds: 0)).then((onValue) {
              return onViewTasks?.call();
            });
          }
        }
      },
      builder: (context, state) {
        final isListening = state is SharaNavigationListening;
        final isThinking = state is SharaNavigationLoading;
        final amplitude = isListening ? state.amplitude : 0.0;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            // color: AppColors.ink,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              VoiceWaveform(
                isRecording: isListening,
                isThinking: isThinking,
                amplitude: amplitude,
              ),
              SizedBox(height: 1.0.h),
              // Text(
              //   message,
              //   textAlign: TextAlign.center,
              //   style: GoogleFonts.roboto(
              //     color: AppColors.white,
              //     fontSize: 16.sp,
              //   ),
              // ),
              // SizedBox(height: 16.h),
              // IconButton.filled(
              //   iconSize: 32.sp,
              //   onPressed: () {
              //     context.read<SharaNavigationBloc>().add(
              //       isListening ? SharaStopListening() : SharaStartListening(),
              //     );
              //   },
              //   icon: Icon(isListening ? Icons.stop : Icons.mic),
              // ),
            ],
          ),
        );
      },
    );
  }
}
