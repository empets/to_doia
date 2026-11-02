import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_church/feature/assistant/shara_ai.dart';
import 'package:grace_church/core/constante/app_colors.dart';

class SharaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;

  const SharaAppBar({super.key, this.leading, this.actions});

  @override
  Size get preferredSize => Size.fromHeight(0.12.sh);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 0.11.sh,
      automaticallyImplyLeading: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: AppColors.transparent,
      backgroundColor: AppColors.background,
      centerTitle: false,
      titleSpacing: 20.w,
      leading: leading,
      title: const SharaAI(),
      actions: [
        ...?actions,
        SizedBox(width: 1.2.w),
      ],
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }
}
