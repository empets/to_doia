import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_doia/core/models/task.dart';

class TaskPreviewTile extends StatelessWidget {
  final Task task;
  const TaskPreviewTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 20.h,
          height: 20.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF6366F1), width: 2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: GoogleFonts.roboto(
                  color: Color(0xFF1A1A2E),
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${task.dateLabel} · ${task.timeLabel}',
                style: GoogleFonts.roboto(
                  color: Color(0xFF6B7280),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        if (task.recurrence != 'Aucune')
          Icon(Icons.repeat_rounded, color: Color(0xFF6366F1), size: 15.h),
      ],
    ),
  );
}
