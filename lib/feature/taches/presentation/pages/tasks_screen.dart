// lib/screens/tasks_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/constante/constantes.dart';
import 'package:grace_church/core/extention/app_extention.dart';
import 'package:grace_church/core/navigation/shara_nav.dart';
import 'package:grace_church/core/service_systeme/model/api/api_state.dart';
import 'package:grace_church/feature/assistant/app_bar_ia.dart';
import 'package:grace_church/feature/assistant/shara_loading_button.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/home/presentation/widget/chart_whithe_grace.dart';
import 'package:grace_church/feature/taches/presentation/bloc/get_task/event/task_event.dart';
import 'package:grace_church/feature/taches/presentation/bloc/get_task/get_list_bloc.dart';
import 'package:grace_church/feature/taches/presentation/pages/task_card.dart';
import 'package:grace_church/feature/taches/presentation/pages/widget/empty_data.dart';
import 'package:grace_church/core/constante/app_colors.dart';
import 'package:grace_church/feature/taches/presentation/pages/widget/task_shimmer.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key, this.onViewTasks, this.onNavigate, this.onCreateTask});
  final VoidCallback? onViewTasks;

  /// Navigation Shara déléguée à l'AppShell.
  final void Function(String destination)? onNavigate;

  /// création de tâche déléguée à l'AppShell.
  final void Function(TaskResponse task)? onCreateTask;
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String _filter = 'Toutes';
  String _search = '';
  bool _searchOpen = false;
  final _filters = ['Toutes', 'ENCOURS', 'TERMINER', "AVENIR", 'ANNULER'];

  // Dans le State du widget
  static const _sections = [
    (status: 'ENCOURS', title: "Aujourd'hui"),
    (status: 'AVENIR', title: 'À venir'),
    (status: 'TERMINER', title: 'Terminées'),
    (status: 'ANNULER', title: 'Annulées'),
  ];

  List<Widget> _buildSections(List<TaskResponse> tasks) {
    final widgets = <Widget>[];

    for (final s in _sections) {
      // final list = tasks.where((t) => t.status == s.status ).toList()
      //   ..sort((a, b) => a.date.compareTo(b.date));
      final list = tasks.where((t) => t.effectiveStatus == s.status).toList()
        ..sort(
          (a, b) =>
              (a.dateTime ?? DateTime(0)).compareTo(b.dateTime ?? DateTime(0)),
        );

      if (list.isEmpty) continue;

      widgets.add(SectionHeader(title: s.title, count: list.length));
      widgets.addAll(
        list.map((t) => TaskCard(task: t, onToggle: () {}, onDelete: () {})),
      );
      widgets.add(SizedBox(height: 12.h));
    }

    return widgets.isEmpty ? [const SizedBox.shrink()] : widgets;
  }

  final TextEditingController _searchController = TextEditingController();
  String capitalizer(String s) =>
      s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';

  // L'état du micro vient de [SharaNavigationBloc] (voir le FAB plus bas).

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetListBloc, ApiState<List<TaskResponse>>>(
      builder: (context, stateTaskList) {
        if (stateTaskList is LoadState<List<TaskResponse>>) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 12.h),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TaskListShimmer(count: 8),
                  ),
                ],
              ),
            ),
          );
        }

        if (stateTaskList is SuccessState<List<TaskResponse>>) {
          return RefreshIndicator(
            color: AppColors.primary,
            backgroundColor: AppColors.white,
            onRefresh: () async {
              context.read<GetListBloc>().add(TaskSectionEvent.fetch(null));
            },
            child: Scaffold(
              appBar: SharaAppBar(
                onViewTasks: widget.onViewTasks,
                onNavigate: widget.onNavigate,
                onCreateTask: widget.onCreateTask,
              ),
              backgroundColor: AppColors.background,
              body: SafeArea(
                top: false,
                child: Column(
                  children: [
                    // ── Header ─────────────────────────────────────────────────────────
                    // SizedBox(height: 29.h),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 1, 20, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Mes Tâches',
                              style: GoogleFonts.roboto(
                                color: AppColors.ink,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          IconBtn(
                            icon: _searchOpen
                                ? Icons.close_rounded
                                : Icons.search_rounded,
                            active: _searchOpen,
                            onTap: () {
                              setState(() {
                                _searchOpen = !_searchOpen;
                                if (!_searchOpen) {
                                  _search = '';
                                  if (_searchController.text.isNotEmpty) {
                                    context.read<GetListBloc>().add(
                                      TaskSectionEvent.fetch(null),
                                    );
                                    _searchController.clear();
                                  }
                                }
                              });
                            },
                          ),
                          SizedBox(width: 8.w),
                          IconBtn(
                            icon: Icons.add_rounded,

                            primary: true,
                            onTap: () {
                              // Flux création via le routeur Shara.
                              // (le /manual-create fournit le FormTastBloc)
                              SharaNav.navigate('create_task');
                            },
                          ),
                        ],
                      ),
                    ),

                    // ── Recherche ───────────────────────────────────────────────────────
                    AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      child: _searchOpen
                          ? Padding(
                              padding: EdgeInsets.fromLTRB(10.w, 12.h, 20.w, 0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.black.withOpacity(0.05),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.search_rounded,
                                      color: AppColors.primary,
                                      size: 18,
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child:
                                          BlocBuilder<
                                            GetListBloc,
                                            ApiState<List<TaskResponse>>
                                          >(
                                            builder: (context, state) {
                                              return TextField(
                                                controller: _searchController,
                                                onChanged: (v) {
                                                  context
                                                      .read<GetListBloc>()
                                                      .add(
                                                        SearchTaskSectionEvent(
                                                          search: v,
                                                          status:
                                                              _filter ==
                                                                  'Toutes'
                                                              ? ''
                                                              : _filter,
                                                        ),
                                                      );
                                                  // context
                                                  //     .read<GetListBloc>()
                                                  //     .add(
                                                  //       TaskSectionEvent.search(
                                                  //         search: v,
                                                  //         status:
                                                  //             _filter.isEmpty
                                                  //             ? ''
                                                  //             : _filter
                                                  //                   .contains(
                                                  //                     'Toutes',
                                                  //                   )
                                                  //             ? ''
                                                  //             : _filter,
                                                  //       ),
                                                  //     );
                                                  // setState(() => _search = v);
                                                },
                                                style: GoogleFonts.roboto(
                                                  color: AppColors.ink,
                                                  fontSize: 14.sp,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Rechercher une tâche...',
                                                  hintStyle: GoogleFonts.roboto(
                                                    color: AppColors.greyText,
                                                  ),
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                        vertical: 14,
                                                      ),
                                                ),
                                              );
                                            },
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ),

                    // ── Filtres ─────────────────────────────────────────────────────────
                    SizedBox(
                      height: 40.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                        children: _filters
                            .map(
                              (f) =>
                                  BlocBuilder<
                                    GetListBloc,
                                    ApiState<List<TaskResponse>>
                                  >(
                                    builder: (context, state) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right: 8,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() => _filter = f);
                                            if (_filter.isNotEmpty &&
                                                _filter.contains("Toutes")) {
                                              context.read<GetListBloc>().add(
                                                TaskSectionEvent.fetch(null),
                                              );
                                              _searchController.value =
                                                  TextEditingValue.empty;
                                            } else {
                                              setState(() => _filter = f);
                                              context.read<GetListBloc>().add(
                                                SearchTaskSectionEvent(
                                                  search:
                                                      _searchController.text,
                                                  status: f == 'Toutes'
                                                      ? ''
                                                      : f,
                                                ),
                                              );

                                              // context.read<GetListBloc>().add(
                                              //   TaskSectionEvent.search(
                                              //     search:
                                              //         _searchController.text
                                              //             .trim()
                                              //             .isEmpty
                                              //         ? ''
                                              //         : _searchController.text
                                              //               .trim(),
                                              //     status: _filter.isEmpty
                                              //         ? ''
                                              //         : _filter.contains(
                                              //             'Toutes',
                                              //           )
                                              //         ? ''
                                              //         : _filter,
                                              //   ),
                                              // );
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16.w,
                                              vertical: 8.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _filter == f
                                                  ? AppColors.primary
                                                  : AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.black
                                                      .withOpacity(0.04),
                                                  blurRadius: 6,
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              capitalizer(f).capitalizeWords,
                                              style: GoogleFonts.roboto(
                                                color: _filter == f
                                                    ? AppColors.white
                                                    : AppColors.greyText,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                            )
                            .toList(),
                      ),
                    ),

                    SizedBox(height: 1.5.h),

                    // ── Liste ───────────────────────────────────────────────────────────
                    Expanded(
                      child:
                          stateTaskList.data.isEmpty &&
                              stateTaskList.refresh == true
                          ? SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 0.1.sh),
                                  EmptyTaskState(
                                    isRefreshing: true,
                                    onRefresh: () {
                                      _searchController.value =
                                          TextEditingValue.empty;

                                      context.read<GetListBloc>().add(
                                        TaskSectionEvent.fetch(null),
                                      );
                                      setState(() {
                                        _filter = 'Toutes';
                                      });
                                    },
                                    onTapMic: () {
                                      // Écoute vocale (mode modification)
                                      SharaNav.startVoice(
                                        TypeCreateTaskOrUpdate.UPDATE_TASK,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          : BlocBuilder<
                              GetListBloc,
                              ApiState<List<TaskResponse>>
                            >(
                              builder: (context, state) {
                                return ListView(
                                  padding: const EdgeInsets.fromLTRB(
                                    20,
                                    8,
                                    20,
                                    24,
                                  ),
                                  children: _buildSections(stateTaskList.data),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
              floatingActionButton:
                  BlocBuilder<SharaNavigationBloc, SharaNavigationState>(
                    builder: (context, state) {
                      final isListening = state is SharaNavigationListening;
                      final isLoading = state is SharaNavigationLoading;

                      return SharaMicButton(
                        isListening: isListening,
                        isLoading: isLoading,
                        onPressed: () {
                          final bloc = context.read<SharaNavigationBloc>();
                          if (isListening) {
                            bloc.add(SharaStopListening());
                          } else if (!isLoading) {
                            bloc.add(SharaStartListening());
                          }
                        },
                      );
                    },
                  ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
