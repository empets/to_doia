import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/constante/app_colors.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.emoji,
    required this.color,
  });
  final String label, emoji;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 14.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(emoji, style: GoogleFonts.roboto(fontSize: 20.sp)),
          SizedBox(height: 6.h),
          Text(
            '$value',
            style: GoogleFonts.roboto(
              color: color,
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.roboto(
              color: AppColors.greyText,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    ),
  );
}
