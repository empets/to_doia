// lib/screens/manual_create_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/alert/app_alerte.dart';
import 'package:grace_church/core/constante/constantes.dart';
import 'package:grace_church/core/custome_widget/button.dart';
import 'package:grace_church/core/custome_widget/form_filed.dart';
import 'package:grace_church/core/extention/app_extention.dart';
import 'package:grace_church/core/injetction/injection_container.dart';
import 'package:grace_church/core/navigation/app_flow_controller.dart';
import 'package:grace_church/core/navigation/shara_route.dart';
import 'package:grace_church/core/navigation/shara_router.dart';
import 'package:grace_church/core/navigation/shara_nav.dart';
import 'package:grace_church/core/succes_screen/success_screen.dart';
import 'package:grace_church/core/voice/voice_listening.dart';
import 'package:grace_church/feature/assistant/app_bar_ia.dart';
import 'package:grace_church/feature/assistant/shara_loading_button.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/home/domaine/usecase/create_task_usecase.dart';
import 'package:grace_church/feature/home/domaine/usecase/update_task_from_usercase.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/create_or_update_task_bloc.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/event/create_tast_event.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/state/create_tast_state.dart';
import 'package:grace_church/feature/home/presentation/widget/chart_whithe_grace.dart'
    show
        SharaNavigationBloc,
        SharaNavigationState,
        SharaNavigationListening,
        SharaNavigationLoading,
        SharaStopListening,
        SharaStartListening;
import 'package:grace_church/feature/taches/presentation/pages/widget/empty_data.dart';
import 'package:grace_church/core/constante/app_colors.dart';

class ManualCreateScreen extends StatefulWidget {
  const ManualCreateScreen({
    super.key,
    this.task,
    this.actionType = TypeCreateTaskOrUpdate.CREATE_TASK,
    this.isPope = false,
    this.onViewTasks,
    this.onNavigate,
    this.onCreateTask,
  });
  final TaskResponse? task;
  final String actionType;
  final bool isPope;
  final VoidCallback? onViewTasks;

  /// Navigation Shara déléguée à l'AppShell.
  final void Function(String destination)? onNavigate;

  /// création de tâche déléguée à l'AppShell.
  final void Function(TaskResponse task)? onCreateTask;

  @override
  State<ManualCreateScreen> createState() => _ManualCreateScreenState();
}

class _ManualCreateScreenState extends State<ManualCreateScreen> {
  final _titleCtrl = TextEditingController();
  DateTime _date = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _time = const TimeOfDay(hour: 9, minute: 0);

  static const _primary = AppColors.primary;

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: _primary,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (d != null) {
      setState(() {
        _date = d;
        _controllerDate.text = '${_date.day}-${_date.month}-${_date.year}';
        context.read<FormTastBloc>().add(
          CreateTaskEvent.changeDate(_controllerDate.text),
        );
      });
      await _pickTime();
    }
  }

  Future<void> _pickTime() async {
    final t = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: _primary,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (t != null) {
      setState(() {
        _time = t;
        _controllerTime.text = '${_time.hour}:${_time.minute}';
        context.read<FormTastBloc>().add(
          CreateTaskEvent.changeTime(_controllerTime.text),
        );
        if ((widget.actionType.contains(TypeCreateTaskOrUpdate.CREATE_TASK))) {
          context.read<FormTastBloc>().add(
            CreateTaskEvent.changeStatus(
              getTaskStatus(date: _date, time: _time),
            ),
          );
        }
      });
    }
  }

  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerContent = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();
  final TextEditingController _controllerTime = TextEditingController();
  final TextEditingController _controllerRecurring = TextEditingController();
  final TextEditingController _controllerStatus = TextEditingController();

  FormTastBloc? formTastBloc;

  @override
  void initState() {
    super.initState();

    formTastBloc = FormTastBloc(
      createTaskUseCase: getIt<CreateTaskUseCase>(),
      updateTaskUseCase: getIt<UpdateTaskUseCase>(),
    );

    if (widget.actionType.contains(TypeCreateTaskOrUpdate.UPDATE_TASK)) {
      if (widget.task != null) {
        _controllerTitle.text = widget.task?.title ?? "";
        _controllerContent.text = widget.task?.content ?? "";
        _controllerDate.text = widget.task?.date ?? "";
        _controllerTime.text = widget.task?.time ?? "";
        _controllerRecurring.text = "false";
        _controllerStatus.text = widget.task?.status ?? "";

        context.read<FormTastBloc>().add(
          CreateTaskEvent.changeTitle(_controllerTitle.text),
        );
        context.read<FormTastBloc>().add(
          CreateTaskEvent.changeTitle(_controllerTitle.text),
        );
        context.read<FormTastBloc>().add(
          CreateTaskEvent.changeTime(_controllerTime.text),
        );
        context.read<FormTastBloc>().add(
          CreateTaskEvent.changeTaskId(widget.task?.taskId ?? ""),
        );
        context.read<FormTastBloc>().add(
          CreateTaskEvent.changeStatus(_controllerStatus.text),
        );
        context.read<FormTastBloc>().add(
          CreateTaskEvent.changeRecurring(false),
        );
        context.read<FormTastBloc>().add(
          CreateTaskEvent.changeDate(_controllerDate.text),
        );
        context.read<FormTastBloc>().add(
          CreateTaskEvent.actionType(widget.actionType),
        );
        context.read<FormTastBloc>().add(
          CreateTaskEvent.changeContent(_controllerContent.text),
        );
      }
    } else if (widget.actionType.contains(TypeCreateTaskOrUpdate.CREATE_TASK)) {
      context.read<FormTastBloc>().add(CreateTaskEvent.changeTaskId(""));
      context.read<FormTastBloc>().add(
        CreateTaskEvent.actionType(widget.actionType),
      );
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  //  permet de voir si la tâche est recussive
  late bool recurring = false;
  late bool isSeletToUseVoix = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: isSeletToUseVoix
          ? SharaAppBar(
              onViewTasks: widget.onViewTasks,
              onNavigate: widget.onNavigate,
              onCreateTask: widget.onCreateTask,
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ───────────────────────────────────────────────────────────
            SizedBox(height: 17.h),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (!isSeletToUseVoix) {
                        // Fermeture : modale → pop du routeur ; écran de
                        // shell (via SharaNav) → retour aux tâches.
                        if (widget.isPope && Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        } else {
                          SharaNav.navigate('tasks');
                        }
                      }
                      if (isSeletToUseVoix) {
                        setState(() {
                          isSeletToUseVoix = false;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(7.h),
                      decoration: BoxDecoration(
                        color: _primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: switch (isSeletToUseVoix) {
                        true => const Icon(
                          Icons.edit,
                          color: _primary,
                          size: 20,
                        ),
                        false => const Icon(
                          Icons.close_rounded,
                          color: _primary,
                          size: 20,
                        ),
                      },
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Text(
                    widget.actionType.contains(
                          TypeCreateTaskOrUpdate.CREATE_TASK,
                        )
                        ? 'Nouvelle tâche'
                        : 'Modifier la tâche',
                    style: GoogleFonts.roboto(
                      color: AppColors.ink,
                      fontSize: 15.h,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  if (widget.actionType.contains(
                    TypeCreateTaskOrUpdate.CREATE_TASK,
                  )) ...[
                    if (!isSeletToUseVoix) ...[
                      // Conseil vocal
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSeletToUseVoix = true;
                          });
                          // Écoute vocale via le routeur (le type d'action est
                          // porté par le contrôleur).
                          // AppFlowController.instance.voiceActionType =
                          //     widget.actionType.trim().isNotEmpty
                          //     ? widget.actionType
                          //     : TypeCreateTaskOrUpdate.CREATE_TASK;
                          // SharaRouter.i.push(SharaRoute.listening);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: _primary.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: _primary.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.mic_rounded,
                                color: _primary,
                                size: 20,
                              ),
                              SizedBox(width: 15.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Conseil : utilisez votre voix !',
                                      style: GoogleFonts.roboto(
                                        color: _primary,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      'Plus rapide avec le microphone.',
                                      style: GoogleFonts.roboto(
                                        color: _primary.withOpacity(0.7),
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ],

                  // Titre
                  Label('Titre de la tâche*'),
                  SizedBox(height: 6.h),

                  BlocBuilder<FormTastBloc, CreateTastState>(
                    builder: (context, state) {
                      return ProductionFormCustomer(
                        controller: _controllerTitle,
                        readOnly: isSeletToUseVoix || state.status.isInProgress,
                        letSpace: [],
                        textLabel: '',
                        inputLabel: '',
                        errorText: state.title.isPure || state.title.isValid
                            ? null
                            : 'Se chant est obligatoire',
                        msgError: 'Se chant est obligatoire',
                        lable: '',
                        fillColor: AppColors.white,
                        borderRaduis: 10.r,
                        minLines: 1,
                        maxLines: 6,
                        onChanged: (_) {
                          context.read<FormTastBloc>().add(
                            CreateTaskEvent.changeTitle(_controllerTitle.text),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: 1.4.h),

                  // Date + Heure
                  Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<FormTastBloc, CreateTastState>(
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 14.h),
                                Row(children: [Label('Date et heure *')]),
                                SizedBox(height: 6.h),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      color: AppColors.grey.withValues(
                                        alpha: 0.4,
                                      ),
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: isSeletToUseVoix ? null : _pickDate,
                                    child: _controllerDate.text.isNotEmpty
                                        ? FieldBox(
                                            icon: Icons.calendar_today_rounded,
                                            text:
                                                '${_controllerDate.text} à ${_controllerTime.text}',
                                          )
                                        : FieldBox(
                                            icon: Icons.calendar_today_rounded,
                                            text: '',
                                          ),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                if ((state.time.isPure || state.time.isValid) &&
                                    (state.date.isPure || state.date.isValid))
                                  const SizedBox.shrink(),
                                if (!(state.time.isPure ||
                                        state.time.isValid) ||
                                    !(state.date.isPure || state.date.isValid))
                                  Label(
                                    'Se chant est obligatoire',
                                    style: GoogleFonts.roboto(
                                      color: AppColors.red,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.6,
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 12.w),
                    ],
                  ),
                  SizedBox(height: 14.h),

                  // Répétition
                  Label('Description'),
                  SizedBox(height: 6.h),
                  BlocBuilder<FormTastBloc, CreateTastState>(
                    builder: (context, state) {
                      return ProductionFormCustomer(
                        controller: _controllerContent,
                        readOnly: isSeletToUseVoix || state.status.isInProgress,
                        letSpace: [],
                        maxLines: 6,
                        minLines: 3,
                        onChanged: (value) {
                          context.read<FormTastBloc>().add(
                            CreateTaskEvent.changeContent(
                              _controllerContent.text,
                            ),
                          );
                        },
                        textLabel: '',
                        inputLabel: '',
                        errorText: state.content.isPure || state.content.isValid
                            ? null
                            : 'Se chant est obligatoire',
                        msgError: 'Se chant est obligatoire',
                        lable: '',
                        fillColor: AppColors.white,
                      );
                    },
                  ),

                  SizedBox(height: 20.h),
                  CustomCheckbox(
                    value: recurring,
                    title: 'Tâche récurrente',
                    subtitle: 'Répéter cette tâche automatiquement',
                    onChanged: isSeletToUseVoix
                        ? (value) {}
                        : (value) {
                            setState(() {
                              recurring = value;
                            });
                            showRecurrenceSheet(context);
                          },
                  ),

                  SizedBox(height: 50.h),

                  // Bouton créer
                  SizedBox(
                    width: double.infinity,
                    child: BlocConsumer<FormTastBloc, CreateTastState>(
                      builder: (context, state) {
                        return PrimaryButton(
                          label:
                              widget.actionType.contains(
                                TypeCreateTaskOrUpdate.CREATE_TASK,
                              )
                              ? "Créer la tâche"
                              : "Modifier la tâche",
                          isLoading: state.status.isInProgress,
                          fontSize: 14.sp,
                          colorText: AppColors.white,
                          backgroundColor: state.status.isInProgress
                              ? _primary.withValues(alpha: 0.4)
                              : _primary,
                          borderRadius: 16,
                          onPressed:
                              state.status.isInProgress || !state.isValide
                              ? null
                              : () async {
                                  context.read<FormTastBloc>().add(
                                    CreateTaskEvent.submit(),
                                  );
                                },
                        );
                      },
                      listener: (context, state) {
                        if (state.status.isSuccess) {
                          if (widget.actionType.contains(
                            TypeCreateTaskOrUpdate.CREATE_TASK,
                          )) {
                            // Tâche enregistrée : succès via le routeur
                            // (rafraîchit la liste + écran de succès).
                            SharaNav.taskConfirmed();
                          }
                          if (widget.actionType.contains(
                            TypeCreateTaskOrUpdate.UPDATE_TASK,
                          )) {
                            Navigator.pop(
                              context,
                              widget.task!.copyWith(
                                title: state.title.value,
                                date: state.date.value,
                                time: state.time.value,
                                recurring: state.recurring,
                                content: state.content.value,
                                taskId: widget.task?.taskId ?? '',
                              ),
                            );
                          }
                        }

                        if (state.status.isFailure) {
                          AppAlert.showError(context, state.errorMessage);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: !isSeletToUseVoix
          ? SizedBox.shrink()
          : BlocBuilder<SharaNavigationBloc, SharaNavigationState>(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String title;
  final String? subtitle;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.subtitle,
  });

  static const Color orange = AppColors.orange;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: value ? _primary.withValues(alpha: 0.07) : AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: value ? _primary : AppColors.grey.shade300,
            width: value ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 18.w,
              height: 18.h,
              decoration: BoxDecoration(
                color: value ? _primary : AppColors.transparent,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  color: value ? _primary : AppColors.grey.shade400,
                  width: 1.5.w,
                ),
              ),
              child: value
                  ? const Icon(
                      Icons.check_rounded,
                      color: AppColors.white,
                      size: 16,
                    )
                  : null,
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.roboto(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.inkAlt3,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      subtitle!,
                      style: GoogleFonts.roboto(
                        fontSize: 11.sp,
                        color: AppColors.grey.shade600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _primary = AppColors.primary;
const _bg = AppColors.background;
const _ink = AppColors.inkDark;
const _muted = AppColors.greyText;

enum RepeatFrequency { daily, weekly, monthly }

/// Règle de répétition (à convertir en modèle Freezed si besoin).
class RecurrenceRule {
  final RepeatFrequency frequency;
  final int interval;
  final Set<int> weekdays; // 1 = lundi ... 7 = dimanche
  final DateTime? endDate;

  const RecurrenceRule({
    this.frequency = RepeatFrequency.daily,
    this.interval = 1,
    this.weekdays = const {},
    this.endDate,
  });

  RecurrenceRule copyWith({
    RepeatFrequency? frequency,
    int? interval,
    Set<int>? weekdays,
    DateTime? endDate,
    bool clearEndDate = false,
  }) => RecurrenceRule(
    frequency: frequency ?? this.frequency,
    interval: interval ?? this.interval,
    weekdays: weekdays ?? this.weekdays,
    endDate: clearEndDate ? null : (endDate ?? this.endDate),
  );

  static const dayNames = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
  static const monthNames = [
    'janv.',
    'févr.',
    'mars',
    'avr.',
    'mai',
    'juin',
    'juil.',
    'août',
    'sept.',
    'oct.',
    'nov.',
    'déc.',
  ];

  static String formatDate(DateTime d) =>
      '${dayNames[d.weekday - 1]} ${d.day} ${monthNames[d.month - 1]}';

  String get label {
    final (unit, prefix) = switch (frequency) {
      RepeatFrequency.daily => (interval == 1 ? 'jour' : 'jours', 'Tous les'),
      RepeatFrequency.weekly => (
        interval == 1 ? 'semaine' : 'semaines',
        'Toutes les',
      ),
      RepeatFrequency.monthly => ('mois', 'Tous les'),
    };
    var text = interval == 1 ? 'Chaque $unit' : '$prefix $interval $unit';
    if (frequency == RepeatFrequency.weekly && weekdays.isNotEmpty) {
      final days = (weekdays.toList()..sort()).map((d) => dayNames[d - 1]);
      text += ' · ${days.join(', ')}';
    }
    if (endDate != null) {
      final d = endDate!;
      text +=
          ' · jusqu\'au ${d.day.toString().padLeft(2, '0')}/'
          '${d.month.toString().padLeft(2, '0')}/${d.year}';
    }
    return text;
  }

  /// Prochaines occurrences à partir d'aujourd'hui (pour l'aperçu).
  List<DateTime> nextDates({DateTime? from, int count = 4}) {
    final now = from ?? DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    int daysBetween(DateTime a, DateTime b) => DateTime.utc(
      b.year,
      b.month,
      b.day,
    ).difference(DateTime.utc(a.year, a.month, a.day)).inDays;

    final startWeekMonday = start.subtract(Duration(days: start.weekday - 1));
    bool matches(DateTime d) {
      switch (frequency) {
        case RepeatFrequency.daily:
          return daysBetween(start, d) % interval == 0;
        case RepeatFrequency.weekly:
          final weeks = daysBetween(startWeekMonday, d) ~/ 7;
          final dayOk = weekdays.isEmpty
              ? d.weekday == start.weekday
              : weekdays.contains(d.weekday);
          return weeks % interval == 0 && dayOk;
        case RepeatFrequency.monthly:
          final months = (d.year - start.year) * 12 + d.month - start.month;
          return months % interval == 0 && d.day == start.day;
      }
    }

    final out = <DateTime>[];
    var d = start;
    for (var i = 0; i < 4000 && out.length < count; i++) {
      if (endDate != null && d.isAfter(endDate!)) break;
      if (matches(d)) out.add(d);
      d = DateTime(d.year, d.month, d.day + 1);
    }
    return out;
  }
}

Future<RecurrenceRule?> showRecurrenceSheet(
  BuildContext context, {
  RecurrenceRule initial = const RecurrenceRule(),
}) {
  return showModalBottomSheet<RecurrenceRule>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    backgroundColor: _bg,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
    ),
    builder: (_) => RecurrenceSheet(initial: initial),
  );
}

enum _Preset { daily, weekdays, weekly, monthly, custom }

class RecurrenceSheet extends StatefulWidget {
  final RecurrenceRule initial;
  const RecurrenceSheet({super.key, required this.initial});

  @override
  State<RecurrenceSheet> createState() => _RecurrenceSheetState();
}

class _RecurrenceSheetState extends State<RecurrenceSheet> {
  late RecurrenceRule _rule = widget.initial;
  late _Preset _preset = _detect(widget.initial);

  static _Preset _detect(RecurrenceRule r) {
    if (r.interval != 1) return _Preset.custom;
    switch (r.frequency) {
      case RepeatFrequency.daily:
        return _Preset.daily;
      case RepeatFrequency.monthly:
        return _Preset.monthly;
      case RepeatFrequency.weekly:
        if (r.weekdays.isEmpty) return _Preset.weekly;
        if (r.weekdays.length == 5 && r.weekdays.every((d) => d <= 5)) {
          return _Preset.weekdays;
        }
        return _Preset.custom;
    }
  }

  void _select(_Preset p) {
    setState(() {
      _preset = p;
      _rule = switch (p) {
        _Preset.daily => _rule.copyWith(
          frequency: RepeatFrequency.daily,
          interval: 1,
          weekdays: <int>{},
        ),
        _Preset.weekdays => _rule.copyWith(
          frequency: RepeatFrequency.weekly,
          interval: 1,
          weekdays: {1, 2, 3, 4, 5},
        ),
        _Preset.weekly => _rule.copyWith(
          frequency: RepeatFrequency.weekly,
          interval: 1,
          weekdays: <int>{},
        ),
        _Preset.monthly => _rule.copyWith(
          frequency: RepeatFrequency.monthly,
          interval: 1,
          weekdays: <int>{},
        ),
        _Preset.custom => _rule,
      };
    });
  }

  Future<void> _pickEndDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _rule.endDate ?? now.add(const Duration(days: 30)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 5)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: _primary, // en-tête, jour sélectionné
              onPrimary:
                  AppColors.white, // texte sur l'en-tête / jour sélectionné
              surface: AppColors.white, // fond du calendrier
              onSurface: _ink, // texte des jours
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: AppColors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: _primary,
              ), // OK / Annuler
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _rule = _rule.copyWith(endDate: picked));
  }

  TextStyle _t(double size, FontWeight w, [Color c = _ink]) =>
      GoogleFonts.roboto(fontSize: size.sp, fontWeight: w, color: c);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // En-tête
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Répéter la tâche', style: _t(20, FontWeight.w700)),
                      SizedBox(height: 2.h),
                      Text(
                        'Choisissez un rythme.',
                        style: _t(13, FontWeight.w400, _muted),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded, color: _muted),
                ),
              ],
            ),
          ),

          // Contenu scrollable
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _presetTile(
                    _Preset.daily,
                    Icons.wb_sunny_outlined,
                    'Tous les jours',
                  ),
                  _presetTile(
                    _Preset.weekdays,
                    Icons.work_outline_rounded,
                    'Du lundi au vendredi',
                  ),
                  _presetTile(
                    _Preset.weekly,
                    Icons.calendar_view_week_rounded,
                    'Chaque semaine',
                  ),
                  _presetTile(
                    _Preset.monthly,
                    Icons.calendar_month_rounded,
                    'Chaque mois',
                  ),
                  _presetTile(
                    _Preset.custom,
                    Icons.tune_rounded,
                    'Personnalisé',
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    alignment: Alignment.topCenter,
                    child: _preset == _Preset.custom
                        ? _customBlock()
                        : const SizedBox(width: double.infinity),
                  ),
                  SizedBox(height: 6.h),
                  _endDateTile(),
                  SizedBox(height: 14.h),
                  _preview(),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),

          // Bouton fixe
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
            child: SizedBox(
              width: double.infinity,
              height: 54.h,
              child: FilledButton(
                onPressed: () => Navigator.pop(context, _rule),
                style: FilledButton.styleFrom(
                  backgroundColor: _primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Valider',
                  style: _t(15, FontWeight.w600, AppColors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Widgets ----------

  Widget _presetTile(_Preset p, IconData icon, String title) {
    final sel = _preset == p;
    return GestureDetector(
      onTap: () => _select(p),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: sel ? _primary.withValues(alpha: 0.08) : AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: sel ? _primary : AppColors.transparent,
            width: 1.5.w,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 38.w,
              height: 38.h,
              decoration: BoxDecoration(
                color: sel ? _primary : _primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                size: 20,
                color: sel ? AppColors.white : _primary,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: _t(14.5, sel ? FontWeight.w600 : FontWeight.w500),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22.w,
              height: 22.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: sel ? _primary : AppColors.transparent,
                border: Border.all(
                  color: sel ? _primary : AppColors.grey.shade300,
                  width: 1.5.w,
                ),
              ),
              child: sel
                  ? const Icon(
                      Icons.check_rounded,
                      size: 14,
                      color: AppColors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _customBlock() {
    final unit = switch (_rule.frequency) {
      RepeatFrequency.daily => _rule.interval == 1 ? 'jour' : 'jours',
      RepeatFrequency.weekly => _rule.interval == 1 ? 'semaine' : 'semaines',
      RepeatFrequency.monthly => 'mois',
    };
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fréquence
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: _bg,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              children: RepeatFrequency.values.map((f) {
                final sel = _rule.frequency == f;
                final name = switch (f) {
                  RepeatFrequency.daily => 'Jour',
                  RepeatFrequency.weekly => 'Semaine',
                  RepeatFrequency.monthly => 'Mois',
                };
                return Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _rule = _rule.copyWith(frequency: f)),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: sel ? AppColors.white : _bg,
                        borderRadius: BorderRadius.circular(11.r),
                        boxShadow: sel
                            ? [
                                // BoxShadow(
                                //   color: AppColors.black.withValues(alpha: 0.06),
                                //   blurRadius: 6,
                                //   offset: const Offset(0, 2),
                                // ),
                              ]
                            : null,
                      ),
                      child: Text(
                        name,
                        style: _t(13, FontWeight.w600, sel ? _primary : _muted),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 18.h),

          // Intervalle
          Row(
            children: [
              Text('Tous les', style: _t(14, FontWeight.w500)),
              const Spacer(),
              _roundBtn(
                Icons.remove_rounded,
                _rule.interval > 1
                    ? () => setState(
                        () => _rule = _rule.copyWith(
                          interval: _rule.interval - 1,
                        ),
                      )
                    : null,
              ),
              SizedBox(
                width: 42.w,
                child: Text(
                  '${_rule.interval}',
                  textAlign: TextAlign.center,
                  style: _t(18, FontWeight.w700),
                ),
              ),
              _roundBtn(
                Icons.add_rounded,
                _rule.interval < 30
                    ? () => setState(
                        () => _rule = _rule.copyWith(
                          interval: _rule.interval + 1,
                        ),
                      )
                    : null,
                filled: true,
              ),
              SizedBox(width: 10.w),
              SizedBox(
                width: 64.w,
                child: Text(unit, style: _t(14, FontWeight.w500, _muted)),
              ),
            ],
          ),

          // Jours de la semaine
          if (_rule.frequency == RepeatFrequency.weekly) ...[
            SizedBox(height: 18.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (i) {
                final day = i + 1;
                final sel = _rule.weekdays.contains(day);
                return GestureDetector(
                  onTap: () {
                    final next = {..._rule.weekdays};
                    sel ? next.remove(day) : next.add(day);
                    setState(() => _rule = _rule.copyWith(weekdays: next));
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 38.w,
                    height: 38.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: sel ? _primary : _bg,
                    ),
                    child: Text(
                      RecurrenceRule.dayNames[i][0],
                      style: _t(
                        13,
                        FontWeight.w600,
                        sel ? AppColors.white : _muted,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 10.h),
            Text(
              _rule.weekdays.isEmpty
                  ? 'Aucun jour choisi : répété le même jour chaque semaine.'
                  : 'Touchez un jour pour l\'ajouter ou le retirer.',
              style: _t(12, FontWeight.w400, _muted),
            ),
          ],
        ],
      ),
    );
  }

  Widget _roundBtn(IconData icon, VoidCallback? onTap, {bool filled = false}) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: filled && enabled ? _primary : _bg,
        ),
        child: Icon(
          icon,
          size: 20,
          color: filled && enabled
              ? AppColors.white
              : (enabled ? _ink : AppColors.grey.shade400),
        ),
      ),
    );
  }

  Widget _endDateTile() {
    final d = _rule.endDate;
    return GestureDetector(
      onTap: _pickEndDate,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              width: 38.w,
              height: 38.h,
              decoration: BoxDecoration(
                color: _primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Icon(
                Icons.event_busy_rounded,
                size: 20,
                color: _primary,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date de fin', style: _t(14.5, FontWeight.w500)),
                  Text(
                    d == null
                        ? 'Jamais'
                        : '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}',
                    style: _t(12.5, FontWeight.w400, _muted),
                  ),
                ],
              ),
            ),
            if (d == null)
              const Icon(Icons.chevron_right_rounded, color: _muted)
            else
              GestureDetector(
                onTap: () =>
                    setState(() => _rule = _rule.copyWith(clearEndDate: true)),
                child: const Icon(Icons.close_rounded, color: _muted),
              ),
          ],
        ),
      ),
    );
  }

  Widget _preview() {
    final dates = _rule.nextDates();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.autorenew_rounded,
                size: 18,
                color: AppColors.white,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  _rule.label,
                  style: _t(14, FontWeight.w600, AppColors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'Prochaines dates',
            style: _t(
              11.5,
              FontWeight.w500,
              AppColors.white.withValues(alpha: 0.75),
            ),
          ),
          SizedBox(height: 8.h),
          if (dates.isEmpty)
            Text(
              'Aucune date à venir',
              style: _t(13, FontWeight.w500, AppColors.white),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: dates
                  .map(
                    (d) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        RecurrenceRule.formatDate(d),
                        style: _t(12, FontWeight.w600, AppColors.white),
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}

/// Petit badge à afficher sur une tâche répétitive (ListTile, Card...).
class RecurrenceBadge extends StatelessWidget {
  final RecurrenceRule rule;
  const RecurrenceBadge({super.key, required this.rule});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.repeat_rounded, size: 14, color: _primary),
          SizedBox(width: 4.w),
          Text(
            rule.label,
            style: GoogleFonts.roboto(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: _primary,
            ),
          ),
        ],
      ),
    );
  }
}
