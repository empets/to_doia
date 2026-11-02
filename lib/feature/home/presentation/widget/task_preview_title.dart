import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/models/task.dart';
import 'package:grace_church/core/constante/app_colors.dart';

class TaskPreviewTile extends StatelessWidget {
  final Task task;
  const TaskPreviewTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(color: AppColors.black.withOpacity(0.04), blurRadius: 8),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 2.0.w,
          height: 2.0.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 2.w),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: GoogleFonts.roboto(
                  color: AppColors.ink,
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${task.dateLabel} · ${task.timeLabel}',
                style: GoogleFonts.roboto(
                  color: AppColors.greyText,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        if (task.recurrence != 'Aucune')
          Icon(Icons.repeat_rounded, color: AppColors.primary, size: 15.h),
      ],
    ),
  );
}
