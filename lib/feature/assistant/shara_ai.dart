import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_church/feature/home/presentation/page/home_screen.dart';
import 'package:grace_church/feature/home/presentation/widget/chart_whithe_grace.dart';
import 'package:grace_church/feature/taches/presentation/pages/tasks_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/constante/app_colors.dart';

class SharaAI extends StatelessWidget {
  const SharaAI({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SharaNavigationBloc, SharaNavigationState>(
      listener: (context, state) {
        if (state is SharaNavigationSuccess) {
          final action = state.response.action;
          final destination = action.destination?.trim().toLowerCase();

          if (destination == 'tasks' || destination == 'mes_taches') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TasksScreen()),
            );
          } else if (destination == 'home' || destination == 'accueil') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HomeScreen(
                  tasks: const [],
                  onMicTap: () {},
                  onViewTasks: () {},
                  onNotif: () {},
                ),
              ),
            );
          }
        }
      },
      builder: (context, state) {
        final isListening = state is SharaNavigationListening;
        final isThinking = state is SharaNavigationLoading;
        final amplitude = isListening ? state.amplitude : 0.0;

        final message = switch (state) {
          SharaNavigationSuccess(:final response) => response.message,
          SharaNavigationError(:final message) => message,
          SharaNavigationListening() => 'Je t’écoute…',
          SharaNavigationLoading() => 'Shara réfléchit…',
          _ => 'Dis « Shara » ou touche le micro.',
        };

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
