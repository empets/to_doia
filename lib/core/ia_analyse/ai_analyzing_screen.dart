// lib/screens/ai_analyzing_screen.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/confirmation/confimation_screen.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';


class AIAnalyzingScreen extends StatefulWidget {
  const AIAnalyzingScreen({super.key, required this.task});

  final TaskResponse task;
  
  @override
  State<AIAnalyzingScreen> createState() => _AIAnalyzingScreenState();
}

class _AIAnalyzingScreenState extends State<AIAnalyzingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _spin = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();
  int _step = 0;

  @override
  void initState() {
    super.initState();
    _animateSteps();
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConfirmationScreen(task: widget.task)),
        );
      }
    });
  }

  void _animateSteps() async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) setState(() => _step = 1);
    await Future.delayed(const Duration(milliseconds: 700));
    if (mounted) setState(() => _step = 2);
  }

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final steps = [
      'Reconnaissance vocale',
      'Analyse des dates',
      'Extraction des détails',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Spinner
                AnimatedBuilder(
                  animation: _spin,
                  builder: (_, child) => Transform.rotate(
                    angle: _spin.value * 2 * pi,
                    child: child,
                  ),
                  child: SizedBox(
                    width: 64,
                    height: 64,
                    child: CustomPaint(painter: _SpinnerPainter()),
                  ),
                ),
                const SizedBox(height: 28),

                 Text(
                  'Je prépare votre rappel...',
                  style: GoogleFonts.roboto(
                    color: Color(0xFF1A1A2E),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                 Text(
                  "L'IA analyse votre demande",
                  style: GoogleFonts.roboto(color: Color(0xFF6B7280), fontSize: 14),
                ),
                const SizedBox(height: 32),

                // Étapes
                ...steps.asMap().entries.map((e) {
                  final done = e.key <= _step;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: done
                                ? const Color(0xFF10B981)
                                : const Color(0xFF6366F1).withOpacity(0.3),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          done ? '${e.value} ✓' : '${e.value}...',
                          style: GoogleFonts.roboto(
                            color: done
                                ? const Color(0xFF10B981)
                                : const Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: done
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF6366F1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final bgPaint = Paint()
      ..color = const Color(0xFF6366F1).withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 8) / 2;

    canvas.drawCircle(center, radius, bgPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      pi * 1.2,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_) => false;
}
