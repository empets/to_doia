// lib/screens/transcription_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_doia/core/ia_analyse/ai_analyzing_screen.dart';

class TranscriptionScreen extends StatelessWidget {
  // final String transcript;
  // final VoidCallback onConfirm;
  // final VoidCallback onRetry;
  // final VoidCallback onCancel;

  const TranscriptionScreen({
    super.key,
    // required this.transcript,
    // required this.onConfirm,
    //required this.onRetry,
    // required this.onCancel
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icône
            Container(
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF6366F1).withValues(alpha: 0.1),
              ),
              child: const Icon(
                Icons.mic_rounded,
                color: Color(0xFF6366F1),
                size: 30,
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Transcription',
              style: GoogleFonts.roboto(
                color: Color(0xFF6B7280),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            // Texte reconnu
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                ),
              ),
              child: Text(
                '"Demain à 10h, rappelle-moi d\'appeler Jean."',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: Color(0xFF1A1A2E),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 10.h),

            // Indicateur de qualité
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF10B981),
                  size: 15.h,
                ),
                const SizedBox(width: 6),
                Text(
                  'Reconnaissance réussie',
                  style: GoogleFonts.roboto(
                    color: Color(0xFF10B981),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 36),

            // Bouton principal
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AIAnalyzingScreen(),
                    ),
                  );
                },
                //onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Analyser avec l\'IA',
                  style: GoogleFonts.roboto(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF6366F1),
                  side: const BorderSide(color: Color(0xFF6366F1)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Recommencer',
                  style: GoogleFonts.roboto(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            TextButton(
              onPressed: () {
                //onCancel
              },
              child: Text(
                'Annuler',
                style: GoogleFonts.roboto(
                  color: Color(0xFF6B7280),
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
