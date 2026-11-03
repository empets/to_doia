import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_church/feature/assistant/shara_ai.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/core/constante/app_colors.dart';

class SharaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SharaAppBar({
    super.key,
    this.leading,
    this.actions,
    this.onViewTasks,
    this.onNavigate,
    this.onCreateTask,
  });

  final Widget? leading;
  final List<Widget>? actions;

  /// Rétro-compatibilité : navigation simple vers la liste des tâches.
  final VoidCallback? onViewTasks;

  /// Callback de navigation déléguée à l'AppShell (overview).
  ///
  /// Si fourni, TOUTES les destinations reconnues par Shara (`tasks`,
  /// `home`, `settings`, `create_task`, …) sont transmises ici et la
  /// machine d'état de l'AppShell décide de l'écran à afficher — la barre
  /// ne pousse plus jamais d'écran elle-même.
  final void Function(String destination)? onNavigate;

  /// création de tâche déléguée à l'AppShell (analyse IA → confirmation).
  final void Function(TaskResponse task)? onCreateTask;

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
      title: SharaAI(
        onViewTasks: onViewTasks,
        onNavigate: onNavigate,
        onCreateTask: onCreateTask,
      ),
      actions: [
        ...?actions,
        SizedBox(width: 1.2.w),
      ],
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }
}
