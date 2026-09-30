import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
           SizedBox(height: 14.h),
          Text(
            'Aucune tâche pour le moment',
            style: GoogleFonts.roboto(
              color: Color(0xFF1A1A2E),
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Appuyez sur le microphone pour\ncréer votre première tâche.',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color: Color(0xFF6B7280),
              fontSize: 14.sp,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: onMic,
            child: Container(
              padding:  EdgeInsets.symmetric(horizontal: 24.h, vertical: 12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.mic_rounded, color: Colors.white, size: 18.h),
                  SizedBox(width: 8),
                  Text(
                    'Créer une tâche',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
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
