import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(emoji, style: GoogleFonts.roboto(fontSize: 20.sp)),
          const SizedBox(height: 6),
          Text(
            '$value',
            style: TextStyle(
              color: color,
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.roboto(
              color: Color(0xFF6B7280),
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    ),
  );
}
