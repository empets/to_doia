// lib/screens/success_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/home/presentation/page/home_screen.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key, this.task});

  final TaskResponse? task;

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );
  late final Animation<double> _scale = CurvedAnimation(
    parent: _ctrl,
    curve: Curves.elasticOut,
  );

  @override
  void initState() {
    super.initState();
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Checkmark animé
            ScaleTransition(
              scale: _scale,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF10B981).withValues(alpha: 0.12),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Color(0xFF10B981),
                  size: 48,
                  weight: 900,
                ),
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'Rappel programmé',
              style: GoogleFonts.roboto(
                color: Color(0xFF10B981),
                fontSize: 17.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'Votre tâche a été créée avec succès',
              style: GoogleFonts.roboto(
                color: Colors.grey.shade600,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 14),

            // Boutons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(
                            tasks: [],
                            onMicTap: () {},
                            onViewTasks: () {},
                            onNotif: () {},
                          ),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF6366F1),
                      side: const BorderSide(
                        color: Color(0xFF6366F1),
                        width: 2,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Accueil',
                      style: GoogleFonts.roboto(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      //widget.onGoTasks
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                      padding:  EdgeInsets.symmetric(vertical: 15.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Mes tâches',
                      style: GoogleFonts.roboto(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
