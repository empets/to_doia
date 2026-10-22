// lib/screens/tasks_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_church/core/constante/constantes.dart';
import 'package:grace_church/core/extention/app_extention.dart';
import 'package:grace_church/core/injetction/injection_container.dart';
import 'package:grace_church/core/models/task.dart';
import 'package:grace_church/core/service_systeme/model/api/api_state.dart';
import 'package:grace_church/core/voice/voice_listening.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/home/domaine/usecase/create_task_usecase.dart';
import 'package:grace_church/feature/home/domaine/usecase/update_task_from_usercase.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/create_or_update_task_bloc.dart';
import 'package:grace_church/feature/taches/presentation/bloc/get_task/event/task_event.dart';
import 'package:grace_church/feature/taches/presentation/bloc/get_task/get_list_bloc.dart';
import 'package:grace_church/feature/taches/presentation/pages/manual_create_screen.dart';
import 'package:grace_church/feature/taches/presentation/pages/task_card.dart';
import 'package:grace_church/feature/taches/presentation/pages/widget/empty_data.dart';

class TasksScreen extends StatefulWidget {
  final List<Task> tasks;
  final void Function(String) onToggle;
  final void Function(String) onDelete;
  final void Function(Task) onRestart;
  final VoidCallback onMicTap;
  final VoidCallback onAddManual;
  final bool showCompleted;

  const TasksScreen({
    super.key,
    required this.tasks,
    required this.onToggle,
    required this.onDelete,
    required this.onRestart,
    required this.onMicTap,
    required this.onAddManual,
    this.showCompleted = true,
  });
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String _filter = 'Toutes';
  String _search = '';
  bool _searchOpen = false;
  final _filters = ['Toutes', 'ENCOURS', 'TERMINER', "AVENIR", 'ANNULER'];

  List<Task> get _filtered {
    var list = widget.tasks;
    if (_search.isNotEmpty) {
      list = list
          .where((t) => t.title.toLowerCase().contains(_search.toLowerCase()))
          .toList();
    }
    switch (_filter) {
      case 'À faire':
        return list.where((t) => !t.done).toList();
      case 'Terminées':
        return list.where((t) => t.done).toList();
      case "Aujourd'hui":
        return list
            .where((t) => !t.done && t.dateLabel == "Aujourd'hui")
            .toList();
      case 'À venir':
        return list
            .where((t) => !t.done && t.dateLabel != "Aujourd'hui")
            .toList();
      default:
        return list;
    }
  }

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
      final list = tasks.where((t) => t.status == s.status).toList()
        ..sort((a, b) => a.date.compareTo(b.date));

      if (list.isEmpty) continue;

      widgets.add(SectionHeader(title: s.title, count: list.length));
      widgets.addAll(
        list.map(
          (t) => TaskCard(
            task: t,
            onToggle: () => widget.onToggle(t.taskId),
            onDelete: () => widget.onDelete(t.taskId),
            // onRestart: () => () {
            //   //widget.onRestart(t.taskId)
            // },
          ),
        ),
      );
      widgets.add(const SizedBox(height: 12));
    }

    return widgets.isEmpty ? [const SizedBox.shrink()] : widgets;
  }

  TextEditingController _searchController = TextEditingController();
  String capitalizer(String s) =>
    s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetListBloc, ApiState<List<TaskResponse>>>(
      builder: (context, stateTaskList) {
        if (stateTaskList is LoadState<List<TaskResponse>>) {
          return Scaffold(
            backgroundColor: const Color(0xFFF4F6FB),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        const Color(0xFF6366F1),
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (stateTaskList is SuccessState<List<TaskResponse>>) {
         

          return RefreshIndicator(
            color: const Color(0xFF6366F1),
            backgroundColor: Colors.white,
            onRefresh: () async {
              context.read<GetListBloc>().add(TaskSectionEvent.fetch(null));
            },
            child: Scaffold(
              backgroundColor: const Color(0xFFF4F6FB),
              body: SafeArea(
                child: Column(
                  children: [
                    // ── Header ─────────────────────────────────────────────────────────
                    SizedBox(height: 29.h),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Mes Tâches',
                              style: TextStyle(
                                color: Color(0xFF1A1A2E),
                                fontSize: 24,
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
                          const SizedBox(width: 8),
                          IconBtn(
                            icon: Icons.add_rounded,
                            primary: true,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => FormTastBloc(
                                      createTaskUseCase: getIt<CreateTaskUseCase>(),
                                      updateTaskUseCase: getIt<UpdateTaskUseCase>(),
                                    ),
                                    child: ManualCreateScreen(
                                      actionType: TypeCreateTaskOrUpdate.CREATE_TASK,
                                      isPope: true,
                                    ),
                                  ),
                                ),
                              );
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
                              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.search_rounded,
                                      color: Color(0xFF6366F1),
                                      size: 18,
                                    ),
                                    const SizedBox(width: 10),
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
                                                        TaskSectionEvent.search(
                                                          search: v,
                                                          status:
                                                              _filter.isEmpty
                                                              ? ''
                                                              : _filter.contains('Toutes')
                                                                  ? ''
                                                                  : _filter,
                                                        ),
                                                      );
                                                  // setState(() => _search = v);
                                                },
                                                style: const TextStyle(
                                                  color: Color(0xFF1A1A2E),
                                                  fontSize: 14,
                                                ),
                                                decoration: const InputDecoration(
                                                  hintText:
                                                      'Rechercher une tâche...',
                                                  hintStyle: TextStyle(
                                                    color: Color(0xFF6B7280),
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
                      height: 52,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        children: _filters
                            .map(
                              (f) => BlocBuilder<
                                GetListBloc,
                                ApiState<List<TaskResponse>>
                              >(
                                builder: (context, state) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() => _filter = f);
                                        if(_filter.isNotEmpty && !_filter.contains("Toutes")){
                                             context.read<GetListBloc>().add(
                                              TaskSectionEvent.fetch(null),
                                            );

                                        }else{
                                            context.read<GetListBloc>().add(
                                          TaskSectionEvent.search(
                                            search: _searchController.text.trim().isEmpty
                                                ? ''
                                                : _searchController.text.trim(),
                                            status: _filter.isEmpty
                                                ? ''
                                                : _filter.contains('Toutes')? '' : _filter,
                                          ),
                                        );

                                        }
                                      
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _filter == f
                                              ? const Color(0xFF6366F1)
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.04,
                                              ),
                                              blurRadius: 6,
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                        capitalizer(f).capitalizeWords,
                                          style: TextStyle(
                                            color: _filter == f
                                                ? Colors.white
                                                : const Color(0xFF6B7280),
                                            fontSize: 13,
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

                    SizedBox(height: 15.h),
                    
          

                    // ── Liste ───────────────────────────────────────────────────────────
                    Expanded(
                      child: stateTaskList.data.isEmpty && stateTaskList.refresh == true
                          ?  SingleChildScrollView(
                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 0.1.sh),
                                              EmptyTaskState(
                                                isRefreshing: true,
                                                onRefresh: () {
                                               _searchController.value = TextEditingValue.empty;

                          context.read<GetListBloc>().add(
                            TaskSectionEvent.fetch(null),
                          );
                          setState(() {
                            _filter = 'Toutes';
                            
                           
                          });
                                                },
                                                onTapMic: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VoiceListeningScreen(
                                  actionType: TypeCreateTaskOrUpdate.UPDATE_TASK,
                                ),
                              ),
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
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
