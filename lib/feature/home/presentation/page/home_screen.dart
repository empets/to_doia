// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/alarme_notification/presentation/pages/simulation_alarme_page.dart';
import 'package:grace_church/core/constante/constantes.dart';
import 'package:grace_church/core/custome_widget/button.dart';
import 'package:grace_church/core/models/task.dart';
import 'package:grace_church/core/service_systeme/model/api/api_state.dart';
import 'package:grace_church/feature/assistant/app_bar_ia.dart';
import 'package:grace_church/feature/assistant/shara_loading_button.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/home/presentation/widget/chart_whithe_grace.dart';
import 'package:grace_church/feature/home/presentation/widget/statcard.dart';
import 'package:grace_church/feature/taches/presentation/bloc/get_task/event/task_event.dart';
import 'package:grace_church/feature/taches/presentation/bloc/get_task/get_list_bloc.dart';
import 'package:grace_church/feature/taches/presentation/pages/task_card.dart';
import 'package:grace_church/feature/taches/presentation/pages/widget/task_shimmer.dart';
import 'package:grace_church/core/constante/app_colors.dart';
import 'package:grace_church/core/navigation/shara_nav.dart';

class HomeScreen extends StatefulWidget {
  final List<Task> tasks;
  final VoidCallback onMicTap;
  final VoidCallback onViewTasks;
  final VoidCallback onNotif;

  /// Navigation Shara déléguée à l'AppShell (null = hérité du comportement
  /// rétro-compatible basé sur [onViewTasks]).
  final void Function(String destination)? onNavigate;

  /// création de tâche déléguée à l'AppShell (analyse IA → confirmation).
  final void Function(TaskResponse task)? onCreateTask;
  const HomeScreen({
    super.key,
    required this.tasks,
    required this.onMicTap,
    required this.onViewTasks,
    required this.onNotif,
    this.onNavigate,
    this.onCreateTask,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

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
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: const Icon(
                        Icons.delete_rounded,
                        color: AppColors.white,
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
      SizedBox(height: 12.h),
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
  //       backgroundColor: AppColors.background,
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
  //                       style: GoogleFonts.roboto(
  //                         color: AppColors.white,
  //                         fontSize: 18.sp,
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
  //                     //   style: GoogleFonts.roboto(color: AppColors.greyText, fontSize: 14.sp),
  //                     // ),
  //                     const SizedBox(height: 2),
  //                     const Text(
  //                       'Que dois-je faire\npour vous ?',
  //                       style: GoogleFonts.roboto(
  //                         color: AppColors.ink,
  //                         fontSize: 24.sp,
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
  //                         color: AppColors.primary.withOpacity(0.1),
  //                         borderRadius: BorderRadius.circular(14),
  //                       ),
  //                       child: Row(
  //                         children: [
  //                           const Icon(
  //                             Icons.task_alt_rounded,
  //                             color: AppColors.primary,
  //                             size: 16,
  //                           ),
  //                           const SizedBox(width: 6),
  //                           Text(
  //                             '$active tâches',
  //                             style: GoogleFonts.roboto(
  //                               color: AppColors.primary,
  //                               fontSize: 12.sp,
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
  //                       color: AppColors.primary,
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
  //                       color: AppColors.success,
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
  //                       color: AppColors.warning,
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
  //                                   AppColors.primaryLight,
  //                                   AppColors.primary,
  //                                 ],
  //                               ),
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   color: AppColors.primary.withValues(
  //                                     alpha: 0.45 + _pulse.value * 0.1,
  //                                   ),
  //                                   blurRadius: 32 + _pulse.value * 8,
  //                                 ),
  //                               ],
  //                             ),
  //                             child: Icon(
  //                               Icons.mic_rounded,
  //                               color: AppColors.white,
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
  //                     color: AppColors.greyText,
  //                     fontSize: 14.sp,
  //                   ),
  //                 ),
  //                 SizedBox(height: 3.h),
  //                 Text(
  //                   'Créez une tâche avec votre voix',
  //                   style: GoogleFonts.roboto(
  //                     color: AppColors.greyText,
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
  //                       color: AppColors.ink,
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
  //                       color: AppColors.primary,
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
  // L'état du micro est porté par [SharaNavigationBloc] : pas de booléen
  // local, sinon l'UI et le bloc se désynchronisent (et le premier tap envoie
  // un Stop au lieu d'un Start).

  late bool isInforLoading = false;

  @override
  Widget build(BuildContext context) {
    final today = widget.tasks
        .where((t) => !t.done && t.dateLabel == "Aujourd'hui")
        .toList();

    return Scaffold(
      appBar: isInforLoading
          ? null
          : SharaAppBar(
              onViewTasks: widget.onViewTasks,
              onNavigate: widget.onNavigate,
              onCreateTask: widget.onCreateTask,
            ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(20.w, 1.h, 20.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Statistiques ────────────────────────────────────
              BlocBuilder<GetListBloc, ApiState<List<TaskResponse>>>(
                builder: (context, state) {
                  if (state is LoadState<List<TaskResponse>>) {
                    return const StatsRowShimmer();
                  }

                  if (state is SuccessState<List<TaskResponse>>) {
                    final tasks = state.data;

                    if (tasks.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return Column(
                      children: [
                        // ── En-tête ─────────────────────────────────────────
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Que dois-je faire\npour vous ?',
                                style: GoogleFonts.roboto(
                                  color: AppColors.ink,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w800,
                                  height: 1.2,
                                ),
                              ),
                            ),
                            BlocBuilder<
                              GetListBloc,
                              ApiState<List<TaskResponse>>
                            >(
                              builder: (context, state) {
                                final active =
                                    state is SuccessState<List<TaskResponse>>
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
                                    // Simulation alarmes — via le routeur Shara.
                                    // SharaNav.navigate('simulation_alarme');
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
                                          color: AppColors.primary,
                                          size: 16.sp,
                                        ),
                                        SizedBox(width: 6.w),
                                        Text(
                                          '$active tâches',
                                          style: GoogleFonts.roboto(
                                            color: AppColors.primary,
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
                        Row(
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
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(width: 5.w),
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
                                color: AppColors.success,
                              ),
                            ),
                            SizedBox(width: 5.w),
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
                                color: AppColors.warning,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),

              SizedBox(height: 3.2.h),

              // ── Tâches du jour ──────────────────────────────────
              if (today.isNotEmpty) ...[
                BlocConsumer<GetListBloc, ApiState<List<TaskResponse>>>(
                  listener: (context, state) {
                    if (state is LoadState<List<TaskResponse>>) {
                      setState(() {
                        isInforLoading = true;
                      });
                    }
                    if (state is SuccessState<List<TaskResponse>> ||
                        state is FailedState<List<TaskResponse>>) {
                      setState(() {
                        isInforLoading = false;
                      });
                    }
                  },
                  builder: (context, state) {
                    return BlocBuilder<
                      GetListBloc,
                      ApiState<List<TaskResponse>>
                    >(
                      builder: (context, state) {
                        if (state is LoadState<List<TaskResponse>>) {
                          return Column(
                            children: [
                              SizedBox(height: 20.h),
                              const TaskListShimmer(count: 7),
                            ],
                          );
                        }

                        if (state is SuccessState<List<TaskResponse>>) {
                          final tasks =
                              state.data
                                  .where(
                                    (t) => t.status.contains(
                                      TypeTaskStatus.AVENIR,
                                    ),
                                  )
                                  .toList()
                                ..sort((a, b) => a.date.compareTo(b.date));

                          if (tasks.isEmpty) {
                            return Column(
                              children: [
                                SizedBox(height: 2.8.h),
                                Text(
                                  'Aucune tâche à venir',
                                  style: GoogleFonts.roboto(
                                    color: AppColors.grey2,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            );
                          }

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 2.8.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Liste des tâches',
                                      style: GoogleFonts.roboto(
                                        color: AppColors.ink,
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
                                        color: AppColors.primary,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              ...tasks.take(2).map((task) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  child: TaskCard(
                                    task: task,
                                    onToggle: () {},
                                    onDelete: () {},
                                  ),
                                );
                              }),
                            ],
                          );
                        }

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 0.36.sh),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Hello, je suis Shara, ton assistant vocal.',
                                style: GoogleFonts.roboto(
                                  color: AppColors.grey2,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: PrimaryButton(
                                label: 'Créer une tâche',
                                colorText: AppColors.white,
                                backgroundColor: AppColors.primary,
                                borderRadius: 12.r,
                                onPressed: () {
                                  SharaNav.navigate('create_task');
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),

      floatingActionButton: isInforLoading
          ? SizedBox.fromSize()
          : BlocBuilder<SharaNavigationBloc, SharaNavigationState>(
              builder: (context, state) {
                final isListening = state is SharaNavigationListening;
                final isLoading = state is SharaNavigationLoading;

                return SharaMicButton(
                  isListening: isListening,
                  isLoading: isLoading,
                  onPressed: () {
                    final bloc = context.read<SharaNavigationBloc>();
                    if (isListening) {
                      bloc.add(SharaStopListening());
                    } else if (!isLoading) {
                      bloc.add(SharaStartListening());
                    }
                  },
                );
              },
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
