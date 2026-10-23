// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/constante/constantes.dart';
import 'package:grace_church/core/extention/app_extention.dart';
import 'package:grace_church/core/injetction/injection_container.dart';
import 'package:grace_church/core/models/task.dart';
import 'package:grace_church/core/service_systeme/model/api/api_state.dart';
import 'package:grace_church/core/voice/voice_listening.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/home/domaine/usecase/shara_navigation_usecase.dart';
import 'package:grace_church/feature/home/presentation/bloc/voice_task.dart';
import 'package:grace_church/feature/home/presentation/widget/chart_whithe_grace.dart'
    hide BlocConsumer;
import 'package:grace_church/feature/home/presentation/widget/statcard.dart';
import 'package:grace_church/feature/taches/presentation/bloc/get_task/event/task_event.dart';
import 'package:grace_church/feature/taches/presentation/bloc/get_task/get_list_bloc.dart';
import 'package:grace_church/feature/taches/presentation/pages/task_card.dart';
import 'package:grace_church/feature/taches/presentation/pages/tasks_screen.dart';
import 'package:grace_church/feature/taches/presentation/pages/widget/empty_data.dart';
import 'package:record/record.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  final List<Task> tasks;
  final VoidCallback onMicTap;
  final VoidCallback onViewTasks;
  final VoidCallback onNotif;
  const HomeScreen({
    super.key,
    required this.tasks,
    required this.onMicTap,
    required this.onViewTasks,
    required this.onNotif,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  List<Widget> _buildSections(List<TaskResponse> tasks) {
    final list =
        tasks.where((t) => t.status.contains(TypeTaskStatus.AVENIR)).toList()
          ..sort((a, b) => a.date.compareTo(b.date));

    if (list.isEmpty) {
      return [const SizedBox.shrink()];
    }

    return [
      ...(list.length > 2
          ? list
                .take(1)
                .map(
                  (t) => Dismissible(
                    key: ValueKey(t.taskId),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: const Icon(
                        Icons.delete_rounded,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (_) {
                      context.read<GetListBloc>().add(
                        TaskSectionEvent.changeTaskStatus(
                          task: t,
                          status: TypeTaskStatus.SUPPRIMER,
                        ),
                      );
                    },
                    child: TaskCard(
                      task: t,
                      onToggle: () {
                        // context.read<TaskBloc>().add(TaskToggled(t.id));
                      },
                      onDelete: () {
                        // context.read<TaskBloc>().add(TaskDeleted(t.id));
                      },
                    ),
                  ),
                )
          : const <Widget>[]),
      const SizedBox(height: 12),
    ];
  }

  // @override
  // Widget build(BuildContext context) {
  //   final today = widget.tasks
  //       .where((t) => !t.done && t.dateLabel == "Aujourd'hui")
  //       .toList();

  //   return BlocProvider(
  //     create: (context) => SharaNavigationBloc(
  //       interact: getIt<SharaInteractUsecase>(),
  //       recorder: AudioRecorder(),
  //       tts: FlutterTts(),
  //     ),
  //     child: Scaffold(
  //       backgroundColor: const Color(0xFFF4F6FB),
  //       body: Column(
  //         // padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
  //         children: [
  //           // ── Header ──────────────────────────────────────────────────────
  //           // SizedBox(height: 16.h),
  //           BlocConsumer<SharaNavigationBloc, SharaNavigationState>(
  //             listener: (context, state) {
  //               if (state is SharaNavigationSuccess) {
  //                 debugPrint('GRACE MESSAGE: ${state.response.message}');
  //                 debugPrint('GRACE ACTION: ${state.response.action.type}');
  //                 debugPrint(
  //                   'GRACE DESTINATION: ${state.response.action.destination}',
  //                 );
  //                 // setState(() {
  //                 //   _message = state.response.message;
  //                 // });

  //                 final action = state.response.action;

  //                 if (action.destination != null &&
  //                     action.destination!.trim().isNotEmpty) {
  //                   switch (action.destination!.toLowerCase()) {
  //                     case 'tasks':
  //                     case 'mes_taches':
  //                       Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                           builder: (context) => TasksScreen(),
  //                         ),
  //                       );
  //                       break;

  //                     case 'home':
  //                     case 'accueil':
  //                       Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                           builder: (context) => HomeScreen(
  //                             tasks: [],
  //                             onMicTap: () {},
  //                             onViewTasks: () {},
  //                             onNotif: () {},
  //                           ),
  //                         ),
  //                       );
  //                       break;

  //                     default:
  //                       debugPrint(
  //                         'Destination inconnue : ${action.destination}',
  //                       );
  //                   }
  //                 }
  //               }

  //               if (state is SharaNavigationError) {
  //                 setState(() {
  //                   // _message = state.message;
  //                 });
  //               }
  //             },
  //             builder: (context, state) {
  //               final isListening = state is SharaNavigationListening;
  //               final isThinking = state is SharaNavigationLoading;
  //               final amplitude = isListening ? state.amplitude : 0.0;
  //               final message = switch (state) {
  //                 SharaNavigationSuccess(:final response) => response.message,
  //                 SharaNavigationError(:final message) => message,
  //                 SharaNavigationListening() => 'Je t’écoute…',
  //                 SharaNavigationLoading() => 'Shara réfléchit…',
  //                 _ => 'Dis « Shara » ou touche le micro.',
  //               };

  //               return Padding(
  //                 padding: const EdgeInsets.all(24),
  //                 child: Column(
  //                   children: [
  //                     const Spacer(),
  //                     VoiceWaveform(
  //                       isRecording: isListening,
  //                       isThinking: isThinking,
  //                       amplitude: amplitude,
  //                     ),
  //                     const SizedBox(height: 32),
  //                     Text(
  //                       message,
  //                       textAlign: TextAlign.center,
  //                       style: const TextStyle(
  //                         color: Colors.white,
  //                         fontSize: 18,
  //                       ),
  //                     ),
  //                     const Spacer(),
  //                     IconButton.filled(
  //                       iconSize: 36,
  //                       onPressed: () =>
  //                           context.read<SharaNavigationBloc>().add(
  //                             isListening
  //                                 ? SharaStopListening()
  //                                 : SharaStartListening(),
  //                           ),
  //                       icon: Icon(isListening ? Icons.stop : Icons.mic),
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             },
  //           ),

  //           /// ========================
  //           ///                         AI
  //           /// ========================
  //           ///
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     // const Text(
  //                     //   'Bonjour 👋',
  //                     //   style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
  //                     // ),
  //                     const SizedBox(height: 2),
  //                     const Text(
  //                       'Que dois-je faire\npour vous ?',
  //                       style: TextStyle(
  //                         color: Color(0xFF1A1A2E),
  //                         fontSize: 24,
  //                         fontWeight: FontWeight.w800,
  //                         height: 1.2,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               BlocBuilder<GetListBloc, ApiState<List<TaskResponse>>>(
  //                 builder: (context, state) {
  //                   int active = 0;
  //                   if (state is SuccessState<List<TaskResponse>>) {
  //                     active = state.data
  //                         .where(
  //                           (x) => x.status.contains(TypeTaskStatus.ENCOURS),
  //                         )
  //                         .length;
  //                   }
  //                   return GestureDetector(
  //                     onTap: () {
  //                       Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                           builder: (_) => const GraceVoiceView(),
  //                           // VoiceWaveform(
  //                           //   height: 10,
  //                           //   isRecording: true,
  //                           //   amplitude: 0.4,
  //                           // ),
  //                           //VoiceChatPage(),
  //                         ),
  //                       );
  //                     },
  //                     child: Container(
  //                       padding: const EdgeInsets.symmetric(
  //                         horizontal: 12,
  //                         vertical: 8,
  //                       ),
  //                       decoration: BoxDecoration(
  //                         color: const Color(0xFF6366F1).withOpacity(0.1),
  //                         borderRadius: BorderRadius.circular(14),
  //                       ),
  //                       child: Row(
  //                         children: [
  //                           const Icon(
  //                             Icons.task_alt_rounded,
  //                             color: Color(0xFF6366F1),
  //                             size: 16,
  //                           ),
  //                           const SizedBox(width: 6),
  //                           Text(
  //                             '$active tâches',
  //                             style: const TextStyle(
  //                               color: Color(0xFF6366F1),
  //                               fontSize: 12,
  //                               fontWeight: FontWeight.w700,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 20),

  //           // ── Statistiques ─────────────────────────────────────────────────
  //           BlocBuilder<GetListBloc, ApiState<List<TaskResponse>>>(
  //             builder: (context, state) {
  //               if (state is LoadState<List<TaskResponse>>) {
  //                 return StatsRowShimmer();
  //               }
  //               if (state is SuccessState<List<TaskResponse>>) {
  //                 return Row(
  //                   children: [
  //                     StatCard(
  //                       label: "Aujourd'hui",
  //                       value: state.data
  //                           .where(
  //                             (x) => x.status.contains(TypeTaskStatus.ENCOURS),
  //                           )
  //                           .length,
  //                       emoji: '📅',
  //                       color: const Color(0xFF6366F1),
  //                     ),
  //                     const SizedBox(width: 10),
  //                     StatCard(
  //                       label: 'À venir',
  //                       value: state.data
  //                           .where(
  //                             (t) => t.status.contains(TypeTaskStatus.AVENIR),
  //                           )
  //                           .length,
  //                       emoji: '⏳',
  //                       color: const Color(0xFF10B981),
  //                     ),
  //                     const SizedBox(width: 10),
  //                     StatCard(
  //                       label: 'Terminées',
  //                       value: state.data
  //                           .where(
  //                             (t) => t.status.contains(TypeTaskStatus.TERMINER),
  //                           )
  //                           .length,
  //                       emoji: '✓',
  //                       color: const Color(0xFFF59E0B),
  //                     ),
  //                   ],
  //                 );
  //               }
  //               return const SizedBox.shrink();
  //             },
  //           ),
  //           const SizedBox(height: 28),

  //           // ── Bouton Microphone ─────────────────────────────────────────────
  //           Center(
  //             child: Column(
  //               children: [
  //                 GestureDetector(
  //                   onTap: () {
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => VoiceListeningScreen(
  //                           actionType: TypeCreateTaskOrUpdate.CREATE_TASK,
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                   //widget.onMicTap,
  //                   child: AnimatedBuilder(
  //                     animation: _pulse,
  //                     builder: (_, _) => SizedBox(
  //                       width: 180,
  //                       height: 180,
  //                       child: Stack(
  //                         alignment: Alignment.center,
  //                         children: [
  //                           // Anneaux pulsants
  //                           ...List.generate(
  //                             3,
  //                             (i) => Container(
  //                               width: 100 + (i + 1) * 26 + _pulse.value * 8,
  //                               height: 100 + (i + 1) * 26 + _pulse.value * 8,
  //                               decoration: BoxDecoration(
  //                                 shape: BoxShape.circle,
  //                                 color: const Color(
  //                                   0xFF6366F1,
  //                                 ).withOpacity(0.08 - i * 0.02),
  //                               ),
  //                             ),
  //                           ),
  //                           // Bouton central
  //                           Container(
  //                             width: 100,
  //                             height: 100,
  //                             decoration: BoxDecoration(
  //                               shape: BoxShape.circle,
  //                               gradient: const LinearGradient(
  //                                 begin: Alignment.topLeft,
  //                                 end: Alignment.bottomRight,
  //                                 colors: [
  //                                   Color(0xFF818CF8),
  //                                   Color(0xFF6366F1),
  //                                 ],
  //                               ),
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   color: const Color(0xFF6366F1).withValues(
  //                                     alpha: 0.45 + _pulse.value * 0.1,
  //                                   ),
  //                                   blurRadius: 32 + _pulse.value * 8,
  //                                 ),
  //                               ],
  //                             ),
  //                             child: Icon(
  //                               Icons.mic_rounded,
  //                               color: Colors.white,
  //                               size: 44.h,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(height: 11.h),
  //                 Text(
  //                   'Appuyez pour parler',
  //                   style: GoogleFonts.roboto(
  //                     color: Color(0xFF6B7280),
  //                     fontSize: 14.sp,
  //                   ),
  //                 ),
  //                 SizedBox(height: 3.h),
  //                 Text(
  //                   'Créez une tâche avec votre voix',
  //                   style: GoogleFonts.roboto(
  //                     color: Color(0xFF6B7280),
  //                     fontSize: 12.sp,
  //                     fontWeight: FontWeight.w400,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           SizedBox(height: 25.h),

  //           // ── Tâches du jour ────────────────────────────────────────────────
  //           if (today.isNotEmpty) ...[
  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: Text(
  //                     "List des tâches",
  //                     style: GoogleFonts.roboto(
  //                       color: Color(0xFF1A1A2E),
  //                       fontSize: 17.sp,
  //                       fontWeight: FontWeight.w700,
  //                     ),
  //                   ),
  //                 ),
  //                 TextButton(
  //                   onPressed: widget.onViewTasks,
  //                   child: Text(
  //                     'Voir tout',
  //                     style: GoogleFonts.roboto(
  //                       color: Color(0xFF6366F1),
  //                       fontSize: 13.sp,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 4.h),
  //             BlocBuilder<GetListBloc, ApiState<List<TaskResponse>>>(
  //               builder: (context, state) {
  //                 if (state is SuccessState<List<TaskResponse>>) {
  //                   if (state.data.isEmpty) return const SizedBox.shrink();
  //                   return Column(
  //                     children: [
  //                       ..._buildSections(state.data),
  //                       Column(
  //                         children: state.data.length > 2
  //                             ? state.data
  //                                   .take(2)
  //                                   .map(
  //                                     (t) => Padding(
  //                                       padding: EdgeInsets.only(bottom: 3.h),
  //                                       child: TaskCard(
  //                                         task: t,
  //                                         onToggle: () {},
  //                                         onDelete: () {},
  //                                       ),
  //                                     ),
  //                                   )
  //                                   .toList()
  //                             : state.data
  //                                   .map(
  //                                     (t) => Padding(
  //                                       padding: EdgeInsets.only(bottom: 3.h),
  //                                       child: TaskCard(
  //                                         task: t,
  //                                         onToggle: () {},
  //                                         onDelete: () {},
  //                                       ),
  //                                     ),
  //                                   )
  //                                   .toList(),
  //                       ),
  //                     ],
  //                   );
  //                 }

  //                 return const SizedBox.shrink();
  //               },
  //             ),
  //           ],
  //           // else
  //           // EmptyState(onMic: widget.onMicTap),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final today = widget.tasks
        .where((t) => !t.done && t.dateLabel == "Aujourd'hui")
        .toList();

    return BlocProvider(
      create: (context) => SharaNavigationBloc(
        interact: getIt<SharaInteractUsecase>(),
        recorder: AudioRecorder(),
        tts: FlutterTts(),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6FB),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── En-tête ─────────────────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Que dois-je faire\npour vous ?',
                        style: GoogleFonts.roboto(
                          color: const Color(0xFF1A1A2E),
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                    ),
                    BlocBuilder<GetListBloc, ApiState<List<TaskResponse>>>(
                      builder: (context, state) {
                        final active = state is SuccessState<List<TaskResponse>>
                            ? state.data
                                  .where(
                                    (t) => t.status.contains(
                                      TypeTaskStatus.ENCOURS,
                                    ),
                                  )
                                  .length
                            : 0;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => TasksScreen()),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF6366F1,
                              ).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.task_alt_rounded,
                                  color: const Color(0xFF6366F1),
                                  size: 16.sp,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  '$active tâches',
                                  style: GoogleFonts.roboto(
                                    color: const Color(0xFF6366F1),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // ── Statistiques ────────────────────────────────────
                BlocBuilder<GetListBloc, ApiState<List<TaskResponse>>>(
                  builder: (context, state) {
                    if (state is LoadState<List<TaskResponse>>) {
                      return const StatsRowShimmer();
                    }

                    if (state is SuccessState<List<TaskResponse>>) {
                      final tasks = state.data;

                      return Row(
                        children: [
                          Expanded(
                            child: StatCard(
                              label: "Aujourd'hui",
                              value: tasks
                                  .where(
                                    (t) => t.status.contains(
                                      TypeTaskStatus.ENCOURS,
                                    ),
                                  )
                                  .length,
                              emoji: '📅',
                              color: const Color(0xFF6366F1),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: StatCard(
                              label: 'À venir',
                              value: tasks
                                  .where(
                                    (t) => t.status.contains(
                                      TypeTaskStatus.AVENIR,
                                    ),
                                  )
                                  .length,
                              emoji: '⏳',
                              color: const Color(0xFF10B981),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: StatCard(
                              label: 'Terminées',
                              value: tasks
                                  .where(
                                    (t) => t.status.contains(
                                      TypeTaskStatus.TERMINER,
                                    ),
                                  )
                                  .length,
                              emoji: '✓',
                              color: const Color(0xFFF59E0B),
                            ),
                          ),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),

                SizedBox(height: 36.h),

                // ── Micro Shara ─────────────────────────────────────
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => VoiceListeningScreen(
                                actionType: TypeCreateTaskOrUpdate.CREATE_TASK,
                              ),
                            ),
                          );
                        },
                        child: AnimatedBuilder(
                          animation: _pulse,
                          builder: (context, child) {
                            final pulse = _pulse.value;

                            return SizedBox(
                              width: 180.w,
                              height: 180.w,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ...List.generate(3, (i) {
                                    final size =
                                        100.w + (i + 1) * 26.w + pulse * 8.w;

                                    return Container(
                                      width: size,
                                      height: size,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(
                                          0xFF6366F1,
                                        ).withValues(alpha: 0.08 - i * 0.02),
                                      ),
                                    );
                                  }),
                                  Container(
                                    width: 100.w,
                                    height: 100.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFF818CF8),
                                          Color(0xFF6366F1),
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF6366F1)
                                              .withValues(
                                                alpha: 0.35 + pulse * 0.1,
                                              ),
                                          blurRadius: 28 + pulse * 8,
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.mic_rounded,
                                      color: Colors.white,
                                      size: 44.sp,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Appuyez pour parler',
                        style: GoogleFonts.roboto(
                          color: const Color(0xFF6B7280),
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Créez une tâche avec votre voix',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: const Color(0xFF6B7280),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                // ── Assistant vocal Shara ───────────────────────────
                BlocConsumer<SharaNavigationBloc, SharaNavigationState>(
                  listener: (context, state) {
                    if (state is SharaNavigationSuccess) {
                      final action = state.response.action;
                      final destination = action.destination
                          ?.trim()
                          .toLowerCase();

                      if (destination == 'tasks' ||
                          destination == 'mes_taches') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => TasksScreen()),
                        );
                      } else if (destination == 'home' ||
                          destination == 'accueil') {
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
                      SharaNavigationSuccess(:final response) =>
                        response.message,
                      SharaNavigationError(:final message) => message,
                      SharaNavigationListening() => 'Je t’écoute…',
                      SharaNavigationLoading() => 'Shara réfléchit…',
                      _ => 'Dis « Shara » ou touche le micro.',
                    };

                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A2E),
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
                          SizedBox(height: 20.h),
                          Text(
                            message,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          IconButton.filled(
                            iconSize: 32.sp,
                            onPressed: () {
                              context.read<SharaNavigationBloc>().add(
                                isListening
                                    ? SharaStopListening()
                                    : SharaStartListening(),
                              );
                            },
                            icon: Icon(isListening ? Icons.stop : Icons.mic),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // ── Tâches du jour ──────────────────────────────────
                if (today.isNotEmpty) ...[
                  SizedBox(height: 28.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Liste des tâches',
                          style: GoogleFonts.roboto(
                            color: const Color(0xFF1A1A2E),
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: widget.onViewTasks,
                        child: Text(
                          'Voir tout',
                          style: GoogleFonts.roboto(
                            color: const Color(0xFF6366F1),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  BlocBuilder<GetListBloc, ApiState<List<TaskResponse>>>(
                    builder: (context, state) {
                      if (state is LoadState<List<TaskResponse>>) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is SuccessState<List<TaskResponse>>) {
                        final tasks =
                            state.data
                                .where(
                                  (t) =>
                                      t.status.contains(TypeTaskStatus.AVENIR),
                                )
                                .toList()
                              ..sort((a, b) => a.date.compareTo(b.date));

                        if (tasks.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: tasks.take(2).map((task) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: TaskCard(
                                task: task,
                                onToggle: () {},
                                onDelete: () {},
                              ),
                            );
                          }).toList(),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatCardShimmer extends StatelessWidget {
  const StatCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: const Color(0xFFE5E7EB).withValues(alpha: 0.6),
        highlightColor: const Color(0xFFF9FAFB).withValues(alpha: 0.8),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: 36,
                height: 18,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 60,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatsRowShimmer extends StatelessWidget {
  const StatsRowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        StatCardShimmer(),
        SizedBox(width: 10),
        StatCardShimmer(),
        SizedBox(width: 10),
        StatCardShimmer(),
      ],
    );
  }
}
