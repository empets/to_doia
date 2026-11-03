// lib/screens/transcription_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/constante/app_colors.dart';
import 'package:grace_church/core/navigation/shara_nav.dart';

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
    backgroundColor: AppColors.white,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icône
            Container(
              width: 6.4.w,
              height: 6.4.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
              child: const Icon(
                Icons.mic_rounded,
                color: AppColors.primary,
                size: 30,
              ),
            ),
            SizedBox(height: 20.h),

            Text(
              'Transcription',
              style: GoogleFonts.roboto(
                color: AppColors.greyText,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),

            // Texte reconnu
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Text(
                '"Demain à 10h, rappelle-moi d\'appeler Jean."',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: AppColors.ink,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 1.0.h),

            // Indicateur de qualité
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 15.h,
                ),
                SizedBox(width: 6.w),
                Text(
                  'Reconnaissance réussie',
                  style: GoogleFonts.roboto(
                    color: AppColors.success,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 36.h),

            // Bouton principal
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AIAnalyzingScreen(

                  //     ),
                  //   ),
                  // );
                },
                //onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
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
            SizedBox(height: 10.h),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  SharaNav.navigate('home');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
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
            SizedBox(height: 10.h),

            TextButton(
              onPressed: () {
                //onCancel
              },
              child: Text(
                'Annuler',
                style: GoogleFonts.roboto(
                  color: AppColors.greyText,
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
