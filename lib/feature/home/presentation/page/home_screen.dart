// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/constante/constantes.dart';
import 'package:grace_church/core/extention/app_extention.dart';
import 'package:grace_church/core/models/task.dart';
import 'package:grace_church/core/service_systeme/model/api/api_state.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/home/presentation/widget/chart_whithe_grace.dart';
import 'package:grace_church/feature/home/presentation/widget/statcard.dart';
import 'package:grace_church/feature/taches/presentation/bloc/get_task/get_list_bloc.dart';
import 'package:grace_church/feature/taches/presentation/pages/task_card.dart';
import 'package:grace_church/feature/taches/presentation/pages/widget/empty_data.dart';
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
    final list = tasks.
    .where((t) => t.effectiveStatus == 'ENCOURS').toList()
      ..sort(
        (a, b) =>
            (a.dateTime ?? DateTime(0)).compareTo(b.dateTime ?? DateTime(0)),
      );

    if (list.isEmpty) {
      return [const SizedBox.shrink()];
    }

    return [
      SectionHeader(title: "Aujourd'hui", count: list.length),
      ...list.map((t) => TaskCard(task: t, onToggle: () {}, onDelete: () {})),
      const SizedBox(height: 12),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final today = widget.tasks
        .where((t) => !t.done && t.dateLabel == "Aujourd'hui")
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          // ── Header ──────────────────────────────────────────────────────
          // SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Text(
                    //   'Bonjour 👋',
                    //   style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                    // ),
                    const SizedBox(height: 2),
                    const Text(
                      'Que dois-je faire\npour vous ?',
                      style: TextStyle(
                        color: Color(0xFF1A1A2E),
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<GetListBloc, ApiState<List<TaskResponse>>>(
                builder: (context, state) {
                  int active = 0;
                  if (state is SuccessState<List<TaskResponse>>) {
                    active = state.data
                        .where((x) => x.status.contains(TypeTaskStatus.ENCOURS))
                        .length;
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const GraceVoiceView(),
                          // VoiceWaveform(
                          //   height: 10,
                          //   isRecording: true,
                          //   amplitude: 0.4,
                          // ),
                          //VoiceChatPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.task_alt_rounded,
                            color: Color(0xFF6366F1),
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '$active tâches',
                            style: const TextStyle(
                              color: Color(0xFF6366F1),
                              fontSize: 12,
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
          const SizedBox(height: 20),

          // ── Statistiques ─────────────────────────────────────────────────
          BlocBuilder<GetListBloc, ApiState<List<TaskResponse>>>(
            builder: (context, state) {
              if (state is LoadState<List<TaskResponse>>) {
                return StatsRowShimmer();
              }
              if (state is SuccessState<List<TaskResponse>>) {
                return Row(
                  children: [
                    StatCard(
                      label: "Aujourd'hui",
                      value: state.data
                          .where(
                            (x) => x.status.contains(TypeTaskStatus.ENCOURS),
                          )
                          .length,
                      emoji: '📅',
                      color: const Color(0xFF6366F1),
                    ),
                    const SizedBox(width: 10),
                    StatCard(
                      label: 'À venir',
                      value: state.data
                          .where(
                            (t) => t.status.contains(TypeTaskStatus.AVENIR),
                          )
                          .length,
                      emoji: '⏳',
                      color: const Color(0xFF10B981),
                    ),
                    const SizedBox(width: 10),
                    StatCard(
                      label: 'Terminées',
                      value: state.data
                          .where(
                            (t) => t.status.contains(TypeTaskStatus.TERMINER),
                          )
                          .length,
                      emoji: '✓',
                      color: const Color(0xFFF59E0B),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const SizedBox(height: 28),

          // ── Bouton Microphone ─────────────────────────────────────────────
          // Center(
          //   child: Column(
          //     children: [
          //       GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          // builder: (context) => VoiceListeningScreen(
          //   actionType: TypeCreateTaskOrUpdate.CREATE_TASK,
          // ),
          //             ),
          //           );
          //         },
          //         //widget.onMicTap,
          //         child: AnimatedBuilder(
          //           animation: _pulse,
          //           builder: (_, _) => SizedBox(
          //             width: 180,
          //             height: 180,
          //             child: Stack(
          //               alignment: Alignment.center,
          //               children: [
          //                 // Anneaux pulsants
          //                 ...List.generate(
          //                   3,
          //                   (i) => Container(
          //                     width: 100 + (i + 1) * 26 + _pulse.value * 8,
          //                     height: 100 + (i + 1) * 26 + _pulse.value * 8,
          //                     decoration: BoxDecoration(
          //                       shape: BoxShape.circle,
          //                       color: const Color(
          //                         0xFF6366F1,
          //                       ).withOpacity(0.08 - i * 0.02),
          //                     ),
          //                   ),
          //                 ),
          //                 // Bouton central
          //                 Container(
          //                   width: 100,
          //                   height: 100,
          //                   decoration: BoxDecoration(
          //                     shape: BoxShape.circle,
          //                     gradient: const LinearGradient(
          //                       begin: Alignment.topLeft,
          //                       end: Alignment.bottomRight,
          //                       colors: [Color(0xFF818CF8), Color(0xFF6366F1)],
          //                     ),
          //                     boxShadow: [
          //                       BoxShadow(
          //                         color: const Color(0xFF6366F1).withValues(
          //                           alpha: 0.45 + _pulse.value * 0.1,
          //                         ),
          //                         blurRadius: 32 + _pulse.value * 8,
          //                       ),
          //                     ],
          //                   ),
          //                   child: Icon(
          //                     Icons.mic_rounded,
          //                     color: Colors.white,
          //                     size: 44.h,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //       SizedBox(height: 11.h),
          //       Text(
          //         'Appuyez pour parler',
          //         style: GoogleFonts.roboto(
          //           color: Color(0xFF6B7280),
          //           fontSize: 14.sp,
          //         ),
          //       ),
          //       SizedBox(height: 3.h),
          //       Text(
          //         'Créez une tâche avec votre voix',
          //         style: GoogleFonts.roboto(
          //           color: Color(0xFF6B7280),
          //           fontSize: 12.sp,
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(height: 25.h),

          // ── Tâches du jour ────────────────────────────────────────────────
          if (today.isNotEmpty) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Aujourd'hui",
                    style: GoogleFonts.roboto(
                      color: Color(0xFF1A1A2E),
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
                      color: Color(0xFF6366F1),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            BlocBuilder<GetListBloc, ApiState<List<TaskResponse>>>(
              builder: (context, state) {
                if (state is SuccessState<List<TaskResponse>>) {
                  if (state.data.isEmpty) return const SizedBox.shrink();
                  return Column(
                    children: [
                      ..._buildSections(state.data),
                      Column(
                        children: state.data.length > 2
                            ? state.data
                                  .take(2)
                                  .map(
                                    (t) => Padding(
                                      padding: EdgeInsets.only(bottom: 3.h),
                                      child: TaskCard(
                                        task: t,
                                        onToggle: () {},
                                        onDelete: () {},
                                      ),
                                    ),
                                  )
                                  .toList()
                            : state.data
                                  .map(
                                    (t) => Padding(
                                      padding: EdgeInsets.only(bottom: 3.h),
                                      child: TaskCard(
                                        task: t,
                                        onToggle: () {},
                                        onDelete: () {},
                                      ),
                                    ),
                                  )
                                  .toList(),
                      ),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
          // else
          // EmptyState(onMic: widget.onMicTap),
        ],
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
