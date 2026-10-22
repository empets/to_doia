import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/alert/app_alerte.dart';
import 'package:grace_church/core/constante/constantes.dart';
import 'package:grace_church/core/extention/app_extention.dart';
import 'package:grace_church/core/injetction/injection_container.dart';
import 'package:grace_church/core/service_systeme/model/api/api_state.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/home/domaine/usecase/create_task_usecase.dart';
import 'package:grace_church/feature/home/domaine/usecase/update_task_from_usercase.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/create_or_update_task_bloc.dart';
import 'package:grace_church/feature/taches/presentation/bloc/get_task/event/task_event.dart';
import 'package:grace_church/feature/taches/presentation/bloc/get_task/get_list_bloc.dart';
import 'package:grace_church/feature/taches/presentation/pages/manual_create_screen.dart';

class TaskCard extends StatefulWidget {
  final TaskResponse task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  // final VoidCallback onRestart;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    // required this.onRestart
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _menuOpen = false;

  static const _primary = Color(0xFF6366F1);

  @override
  Widget build(BuildContext context) {
    final t = widget.task;

    return t.status.contains(TypeTaskStatus.SUPPRIMER)
        ? const SizedBox()
        : GestureDetector(
            onTap: () => setState(() => _menuOpen = false),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: false
                    ? null
                    : Border.all(color: _primary.withOpacity(0.08)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Checkbox
                      BlocBuilder<GetListBloc, ApiState<List<TaskResponse>>>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: t.status.contains(TypeTaskStatus.TERMINER)
                                ? () {
                                    context.read<GetListBloc>().add(
                                      TaskSectionEvent.changeTaskStatus(
                                        task: widget.task,
                                        status: TypeTaskStatus.ENCOURS,
                                      ),
                                    );
                                  }
                                : (() {
                                    final isExpired = isDateExpired(
                                      widget.task.date,
                                      widget.task.time,
                                    );
                                    if (isExpired) {
                                      context.read<GetListBloc>().add(
                                        TaskSectionEvent.changeTaskStatus(
                                          task: widget.task,
                                          status: TypeTaskStatus.TERMINER,
                                        ),
                                      );
                                    }
                                    if (!isExpired) {
                                      AppAlert.showInfo(
                                        context,
                                        'Cette tâche ne peut pas être marquée comme terminée car sa date d\'échéance est dépassée.',
                                      );
                                    }
                                  }),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: t.status.contains("TERMINER")
                                    ? _primary
                                    : Colors.transparent,
                                border: Border.all(
                                  color: _primary.withOpacity(0.5),
                                  width: 2,
                                ),
                              ),
                              child: t.status.contains("TERMINER")
                                  ? const Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                      size: 13,
                                    )
                                  : null,
                            ),
                          );
                        },
                      ),

                      const SizedBox(width: 12),

                      // Textes : prennent l'espace disponible et passent à la ligne
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.title,
                              softWrap: true,
                              style: GoogleFonts.roboto(
                                color: const Color(0xFF6B7280),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                decoration:
                                    t.status.contains(TypeTaskStatus.ANNULER)
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                decorationColor: const Color(0xFF6B7280),
                              ),
                            ),
                            Text(
                              t.content,
                              softWrap: true,
                              style: GoogleFonts.roboto(
                                color: const Color(0xFF6B7280),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                decoration:
                                    t.status.contains(TypeTaskStatus.ANNULER)
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                decorationColor: const Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Menu "···"
                      GestureDetector(
                        onTap: () => setState(() => _menuOpen = !_menuOpen),
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.more_horiz_rounded,
                            color: Color(0xFF6B7280),
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Méta (date + heure + récurrence)
                  Padding(
                    padding: const EdgeInsets.only(left: 34, top: 6),
                    child: Wrap(
                      spacing: 8,
                      children: [
                        Row(
                          children: [
                            _Tag(icon: Icons.calendar_today_rounded, text: ""),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    if (t.date.isNotEmpty)
                                      TextSpan(
                                        text: formatDateString(t.date),
                                        style: GoogleFonts.roboto(
                                          color: Colors.grey.shade600,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600,
                                          decoration:
                                              t.status.contains("ANNULER")
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                        ),
                                      ),
                                    if (t.time.isNotEmpty)
                                      TextSpan(
                                        text: ' à ${t.time}',
                                        style: GoogleFonts.roboto(
                                          color: Colors.grey.shade600,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            if (t.status.contains("TERMINER"))
                              _Tag(
                                icon: Icons.check_circle_rounded,
                                text: 'Terminée',
                                color: const Color(0xFF10B981),
                              ),
                            if (widget.task.status.contains(
                              TypeTaskStatus.ENCOURS,
                            ))
                              _Tag(
                                icon: Icons.access_time_rounded,
                                text:
                                    widget.task.status.contains(
                                      TypeTaskStatus.ENCOURS,
                                    )
                                    ? 'En cours'
                                    : '',
                                color: const Color(0xFFF59E0B),
                              ),
                          ],
                        ),

                        // if (t.recurring)
                        //   _Tag(
                        //     icon: Icons.repeat_rounded,
                        //     text: "Répétition",
                        //     color: _primary,
                        //   ),
                      ],
                    ),
                  ),

                  // Menu contextuel
                  if (_menuOpen)
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F6FB),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Column(
                        children: [
                          if (true)
                            if (!widget.task.status.contains(
                              TypeTaskStatus.TERMINER,
                            )) ...[
                              BlocBuilder<
                                GetListBloc,
                                ApiState<List<TaskResponse>>
                              >(
                                builder: (context, state) {
                                  return _MenuItem(
                                    icon: Icons.check_circle_outline_rounded,
                                    color: const Color(0xFF10B981),
                                    label: 'Marquer comme terminée',
                                    onTap: () {
                                      final isExpired = isDateExpired(
                                        widget.task.date,
                                        widget.task.time,
                                      );
                                      if (isExpired) {
                                        context.read<GetListBloc>().add(
                                          TaskSectionEvent.changeTaskStatus(
                                            task: widget.task,
                                            status: TypeTaskStatus.TERMINER,
                                          ),
                                        );
                                      }
                                      if (!isExpired) {
                                        AppAlert.showInfo(
                                          context,
                                          'Cette tâche ne peut pas être marquée comme terminée car sa date d\'échéance est dépassée.',
                                        );
                                      }

                                      setState(() => _menuOpen = false);
                                      widget.onToggle();
                                    },
                                  );
                                },
                              ),
                              // if (true)
                              //   _MenuItem(
                              //     icon: Icons.refresh_rounded,
                              //     color: _primary,
                              //     label: 'Réactiver la tâche',
                              //     onTap: () {
                              //       setState(() => _menuOpen = false);
                              //       // widget.onRestart();
                              //     },
                              //   ),
                              const Divider(
                                height: 1,
                                color: Color(0xFFE5E7EB),
                              ),
                            ],

                          if (!widget.task.status.contains(
                            TypeTaskStatus.ANNULER,
                          )) ...[
                            BlocBuilder<
                              GetListBloc,
                              ApiState<List<TaskResponse>>
                            >(
                              builder: (context, state) {
                                return _MenuItem(
                                  icon: Icons.close,
                                  color: Colors.grey,
                                  label: 'Annuler',
                                  onTap: () {
                                    context.read<GetListBloc>().add(
                                      TaskSectionEvent.changeTaskStatus(
                                        task: widget.task,
                                        status: TypeTaskStatus.ANNULER,
                                      ),
                                    );
                                    setState(() => _menuOpen = false);
                                    widget.onToggle();
                                  },
                                );
                              },
                            ),
                            // if (true)
                            //   _MenuItem(
                            //     icon: Icons.refresh_rounded,
                            //     color: _primary,
                            //     label: 'Réactiver la tâche',
                            //     onTap: () {
                            //       setState(() => _menuOpen = false);
                            //       // widget.onRestart();
                            //     },
                            //   ),
                            const Divider(height: 1, color: Color(0xFFE5E7EB)),
                          ],

                          BlocBuilder<
                            GetListBloc,
                            ApiState<List<TaskResponse>>
                          >(
                            builder: (context, state) {
                              return _MenuItem(
                                icon: Icons.edit_outlined,
                                color: const Color(0xFFF59E0B),
                                label: 'Modifier',
                                onTap: () async {
                                  //
                                  final result = await Navigator.of(context)
                                      .push<TaskResponse>(
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) => FormTastBloc(
                                              createTaskUseCase:
                                                  getIt<CreateTaskUseCase>(),
                                              updateTaskUseCase:
                                                  getIt<UpdateTaskUseCase>(),
                                            ),
                                            child: ManualCreateScreen(
                                              task: widget.task,
                                              actionType: TypeCreateTaskOrUpdate
                                                  .UPDATE_TASK,
                                              isPope: true,
                                            ),
                                          ),
                                        ),
                                      );
                                  if (result != null) {
                                    context.read<GetListBloc>().add(
                                      TaskSectionEvent.changeTask(result),
                                    );
                                    setState(() => _menuOpen = false);
                                  }
                                },
                              );
                            },
                          ),
                          const Divider(height: 1, color: Color(0xFFE5E7EB)),
                          BlocBuilder<
                            GetListBloc,
                            ApiState<List<TaskResponse>>
                          >(
                            builder: (context, state) {
                              return _MenuItem(
                                icon: Icons.delete_outline_rounded,
                                color: const Color(0xFFEF4444),
                                label: 'Supprimer',
                                onTap: () {
                                  context.read<GetListBloc>().add(
                                    TaskSectionEvent.changeTaskStatus(
                                      task: widget.task,
                                      status: TypeTaskStatus.SUPPRIMER,
                                    ),
                                  );
                                  setState(() => _menuOpen = false);
                                  widget.onDelete();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
  }
}

class _Tag extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const _Tag({
    required this.icon,
    required this.text,
    this.color = const Color(0xFF6B7280),
  });

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 12.sp, color: color),
      const SizedBox(width: 3),
      Text(
        text,
        style: GoogleFonts.roboto(color: color, fontSize: 10.sp),
      ),
    ],
  );
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;
  const _MenuItem({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      child: Row(
        children: [
          Icon(icon, color: color, size: 13.h),
          SizedBox(width: 8.w),
          Text(
            label,
            style: GoogleFonts.roboto(
              color: color,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}
