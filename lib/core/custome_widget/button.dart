import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/constante/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.backgroundColor,
    this.colorText,
    this.borderSideColor,
    this.iconColor = AppColors.white,
    this.fontSize,
    this.iconLeading = false,
    this.leadingIcon,
    this.borderRadius = 6,
  });
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? colorText;
  final Color? borderSideColor;
  final double? fontSize;
  final Color? iconColor;
  final bool iconLeading;
  final IconData? leadingIcon;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: 40.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          overlayColor: AppColors.transparent,
          backgroundColor: backgroundColor ?? AppColors.blue,
          foregroundColor: AppColors.blue,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderSideColor ?? AppColors.transparent),
            borderRadius: BorderRadius.circular(borderRadius ?? 6.r),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.h,
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  backgroundColor: AppColors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  if (iconLeading && leadingIcon != null) ...[
                    Icon(leadingIcon, size: 13.h, color: iconColor),
                    SizedBox(width: 3.w),
                  ],

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 9.h),
                    child: Row(
                      children: [
                        Text(
                          label,
                          style: GoogleFonts.roboto(
                            color: colorText,
                            fontSize: fontSize ?? 16.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        // SizedBox(width: 8.w),
                      ],
                    ),
                  ),
                  if (icon != null) ...[
                    Icon(icon, size: 13.h, color: iconColor),
                    SizedBox(width: 7.w),
                  ],
                ],
              ),
      ),
    );
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({
    super.key,
    required this.label,
    required this.textToShare,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.backgroundColor,
    this.colorText,
    this.borderSideColor,
    this.iconColor = AppColors.white,
    this.fontSize,
    this.iconLeading = false,
    this.leadingIcon,
    this.borderRadius = 6,
    //  required this.onPressed,
  });

  final String label;
  final String textToShare;
  // final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? colorText;
  final Color? borderSideColor;
  final double? fontSize;
  final Color? iconColor;
  final bool iconLeading;
  final IconData? leadingIcon;
  final double? borderRadius;
  // final String? subject;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          backgroundColor: backgroundColor ?? AppColors.blue,
          foregroundColor: AppColors.blue,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderSideColor ?? AppColors.transparent),
            borderRadius: BorderRadius.circular(borderRadius ?? 6),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.h,
                child: CircularProgressIndicator(),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (iconLeading && leadingIcon != null) ...[
                    Icon(leadingIcon, size: 10.h, color: iconColor),
                    SizedBox(width: 2.w),
                  ],

                  Flexible(
                    child: Text(
                      label,
                      style: GoogleFonts.roboto(
                        color: colorText ?? AppColors.white,
                        fontSize: fontSize ?? 16,
                        fontWeight: FontWeight.w600,
                        // letterSpacing: 0.5,
                      ),
                    ),
                  ),

                  // if (icon != null) ...[
                  //   const SizedBox(width: 8),
                  //   Icon(
                  //     icon,
                  //     size: 16,
                  //     color: iconColor,
                  //   ),
                  // ],
                ],
              ),
      ),
    );
  }
}
