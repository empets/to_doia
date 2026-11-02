import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/constante/app_colors.dart';

class EmptyTaskState extends StatelessWidget {
  final VoidCallback onTapMic;
  final bool isRefreshing;
  final VoidCallback onRefresh;

  const EmptyTaskState({
    super.key,
    required this.onTapMic,
    required this.isRefreshing,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('📋', style: GoogleFonts.roboto(fontSize: 52.sp)),
        SizedBox(height: 14.h),
        Text(
          'Aucune tâche trouvée suite à votre recherche',
          style: GoogleFonts.roboto(
            color: AppColors.ink,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20.h),
        if (isRefreshing) ...[
          GestureDetector(
            onTap: onRefresh,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh_rounded, color: AppColors.white, size: 18),
                  SizedBox(width: 8.w),
                  Text(
                    'Rafraîchir',
                    style: GoogleFonts.roboto(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 1.4.h),
        ],
        GestureDetector(
          onTap: onTapMic,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: isRefreshing ? AppColors.primary : AppColors.transparent,
              ),
              color: isRefreshing
                  ? AppColors.transparent
                  : AppColors.primary,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.mic_rounded, color: AppColors.black, size: 18),
                SizedBox(width: 8.w),
                Text(
                  'Créer une nouvelle tâche',
                  style: GoogleFonts.roboto(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 1.4.h),
      ],
    ),
  );
}

class SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  final bool isHome;
  final void Function()? onPressed;
  const SectionHeader({
    super.key,
    required this.title,
    required this.count,
    this.isHome = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10, top: 4),
    child: Row(
      children: [
        if (isHome) ...[
          Row(
            children: [
              Expanded(
                child: Text(
                  "Aujourd'hui",
                  style: GoogleFonts.roboto(
                    color: AppColors.ink,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextButton(
                onPressed: onPressed,
                child: Text(
                  'Voir tout',
                  style: GoogleFonts.roboto(
                    color: AppColors.primary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
        if (!isHome) ...[
          Text(
            title,
            style: GoogleFonts.roboto(
              color: AppColors.ink,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count',
              style: GoogleFonts.roboto(
                color: AppColors.primary,
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

class IconBtn extends StatelessWidget {
  final IconData icon;
  final bool active, primary;
  final VoidCallback onTap;
  const IconBtn({
    super.key,
    required this.icon,
    required this.onTap,
    this.active = false,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 36.w,
      height: 36.h,
      decoration: BoxDecoration(
        color: primary || active
            ? AppColors.primary
            : AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: primary || active ? AppColors.white : AppColors.primary,
        size: 20,
      ),
    ),
  );
}

class Label extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const Label(this.text, {super.key, this.style});
  @override
  Widget build(BuildContext context) => Text(
    text,
    style:
        style ??
        GoogleFonts.roboto(
          color: AppColors.greyText,
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
  );
}

class FieldBox extends StatelessWidget {
  final IconData icon;
  final String text;
  const FieldBox({super.key, required this.icon, required this.text});
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 13),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 17),
        SizedBox(width: 8.w),
        Text(
          text,
          style: GoogleFonts.roboto(color: AppColors.ink, fontSize: 13.sp),
        ),
      ],
    ),
  );
}
