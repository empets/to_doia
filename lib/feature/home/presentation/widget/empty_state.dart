import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/constante/app_colors.dart';

class EmptyState extends StatelessWidget {
  final VoidCallback onMic;
  const EmptyState({super.key, required this.onMic});

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Text('📋', style: GoogleFonts.roboto(fontSize: 52.sp)),
           SizedBox(height: 1.4.h),
          Text(
            'Aucune tâche pour le moment',
            style: GoogleFonts.roboto(
              color: AppColors.ink,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Appuyez sur le microphone pour\ncréer votre première tâche.',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color: AppColors.greyText,
              fontSize: 14.sp,
              height: 1.6,
            ),
          ),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: onMic,
            child: Container(
              padding:  EdgeInsets.symmetric(horizontal: 24.h, vertical: 12.w),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.mic_rounded, color: AppColors.white, size: 18.h),
                  SizedBox(width: 8.w),
                  Text(
                    'Créer une tâche',
                    style: GoogleFonts.roboto(
                      color: AppColors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
