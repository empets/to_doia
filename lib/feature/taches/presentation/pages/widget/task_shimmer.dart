import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_church/core/constante/app_colors.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

/// Bloc "squelette" : doit être blanc opaque, le Shimmer le recolore.
class _Bone extends StatelessWidget {
  final double? width;
  final double height;
  final double radius;
  const _Bone({this.width, required this.height, this.radius = 8});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

class _ShimmerWrap extends StatelessWidget {
  final Widget child;
  const _ShimmerWrap({required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.border.withValues(alpha: 0.6),
      highlightColor: AppColors.backgroundAlt1.withValues(alpha: 0.8),
      child: child,
    );
  }
}

class StatCardShimmer extends StatelessWidget {
  const StatCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.backgroundAlt3),
      ),
      child: _ShimmerWrap(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Bone(width: 28.w, height: 28.w, radius: 14.r),
            SizedBox(height: 12.h),
            _Bone(width: 36.w, height: 18.h, radius: 6.r),
            SizedBox(height: 8.h),
            _Bone(width: 60.w, height: 10.h, radius: 6.r),
          ],
        ),
      ),
    );
  }
}

class StatsRowShimmer extends StatelessWidget {
  const StatsRowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: StatCardShimmer()),
        SizedBox(width: 10.w),
        const Expanded(child: StatCardShimmer()),
        SizedBox(width: 10.w),
        const Expanded(child: StatCardShimmer()),
      ],
    );
  }
}

class TaskCardShimmer extends StatelessWidget {
  const TaskCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.backgroundAlt3),
      ),
      child: _ShimmerWrap(
        child: Row(
          children: [
            _Bone(width: 22.w, height: 22.w, radius: 11.r),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FractionallySizedBox(
                    widthFactor: 0.7,
                    child: _Bone(height: 16.h, radius: 6.r),
                  ),
                  SizedBox(height: 8.h),
                  FractionallySizedBox(
                    widthFactor: 0.4,
                    child: _Bone(height: 10.h, radius: 6.r),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            _Bone(width: 20.w, height: 20.w, radius: 6.r),
          ],
        ),
      ),
    );
  }
}

class TaskListShimmer extends StatelessWidget {
  final int count;
  const TaskListShimmer({super.key, this.count = 2});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        count,
        (_) => Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: const TaskCardShimmer(),
        ),
      ),
    );
  }
}
