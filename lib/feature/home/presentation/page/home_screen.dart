// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_doia/core/models/task.dart';
import 'package:to_doia/core/voice/voice_listening.dart';
import 'package:to_doia/feature/home/presentation/widget/empty_state.dart';
import 'package:to_doia/feature/home/presentation/widget/statcard.dart';
import 'package:to_doia/feature/home/presentation/widget/task_preview_title.dart';

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

  @override
  Widget build(BuildContext context) {
    final today = widget.tasks
        .where((t) => !t.done && t.dateLabel == "Aujourd'hui")
        .toList();
    final upcoming = widget.tasks
        .where((t) => !t.done && t.dateLabel != "Aujourd'hui")
        .length;
    final done = widget.tasks.where((t) => t.done).length;
    final active = widget.tasks.where((t) => !t.done).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            // ── Header ──────────────────────────────────────────────────────
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bonjour 👋',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 14,
                        ),
                      ),
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
                GestureDetector(
                  onTap: widget.onNotif,
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
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ── Statistiques ─────────────────────────────────────────────────
            Row(
              children: [
                StatCard(
                  label: "Aujourd'hui",
                  value: today.length,
                  emoji: '📅',
                  color: const Color(0xFF6366F1),
                ),
                const SizedBox(width: 10),
                StatCard(
                  label: 'À venir',
                  value: upcoming,
                  emoji: '⏳',
                  color: const Color(0xFF10B981),
                ),
                const SizedBox(width: 10),
                StatCard(
                  label: 'Terminées',
                  value: done,
                  emoji: '✓',
                  color: const Color(0xFFF59E0B),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // ── Bouton Microphone ─────────────────────────────────────────────
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VoiceListeningScreen(),
                        ),
                      );
                    },
                    //widget.onMicTap,
                    child: AnimatedBuilder(
                      animation: _pulse,
                      builder: (_, _) => SizedBox(
                        width: 180,
                        height: 180,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Anneaux pulsants
                            ...List.generate(
                              3,
                              (i) => Container(
                                width: 100 + (i + 1) * 26 + _pulse.value * 8,
                                height: 100 + (i + 1) * 26 + _pulse.value * 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(
                                    0xFF6366F1,
                                  ).withOpacity(0.08 - i * 0.02),
                                ),
                              ),
                            ),
                            // Bouton central
                            Container(
                              width: 100,
                              height: 100,
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
                                    color: const Color(0xFF6366F1).withValues(
                                      alpha: 0.45 + _pulse.value * 0.1,
                                    ),
                                    blurRadius: 32 + _pulse.value * 8,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.mic_rounded,
                                color: Colors.white,
                                size: 44.h,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 11.h),
                  Text(
                    'Appuyez pour parler',
                    style: GoogleFonts.roboto(
                      color: Color(0xFF6B7280),
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'Créez une tâche avec votre voix',
                    style: GoogleFonts.roboto(
                      color: Color(0xFF6B7280),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
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
              const SizedBox(height: 8),
              ...today
                  .take(3)
                  .map(
                    (t) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TaskPreviewTile(task: t),
                    ),
                  ),
            ] else
              EmptyState(onMic: widget.onMicTap),
          ],
        ),
      ),
    );
  }
}
