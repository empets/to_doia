// lib/screens/manual_create_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/alert/app_alerte.dart';
import 'package:grace_church/core/constante/constantes.dart';
import 'package:grace_church/core/custome_widget/button.dart';
import 'package:grace_church/core/custome_widget/navigate.dart';
import 'package:grace_church/core/injetction/injection_container.dart';
import 'package:grace_church/core/succes_screen/success_screen.dart';
import 'package:grace_church/core/voice/voice_listening.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/home/domaine/usecase/create_task_usecase.dart';
import 'package:grace_church/feature/home/domaine/usecase/update_task_from_usercase.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/create_or_update_task_bloc.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/event/create_tast_event.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/state/create_tast_state.dart';
import 'package:grace_church/feature/taches/presentation/pages/widget/empty_data.dart';

class ManualCreateScreen extends StatefulWidget {
  const ManualCreateScreen({super.key, this.task, this.actionType = ''});
  final TaskResponse? task;
  final String actionType;

  @override
  State<ManualCreateScreen> createState() => _ManualCreateScreenState();
}

class _ManualCreateScreenState extends State<ManualCreateScreen> {
  final _titleCtrl = TextEditingController();
  DateTime _date = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _time = const TimeOfDay(hour: 9, minute: 0);

  static const _primary = Color(0xFF6366F1);

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
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (d != null) {
      setState(() {
        _date = d;
        _controllerDate.text = '${_date.day}/${_date.month}/${_date.year} ';
        context.read<FormTastBloc>().add(
          CreateTaskEvent.changeDate(_controllerDate.text),
        );
      });
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
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
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
      context.read<FormTastBloc>().add(CreateTaskEvent.changeTaskId("1"));
      context.read<FormTastBloc>().add(
        CreateTaskEvent.changeStatus(_controllerStatus.text),
      );
      context.read<FormTastBloc>().add(CreateTaskEvent.changeRecurring(false));
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
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF4F6FB),
    body: SafeArea(
      child: Column(
        children: [
          // ── Header ───────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: _primary,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  'Nouvelle tâche',
                  style: GoogleFonts.roboto(
                    color: Color(0xFF1A1A2E),
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
                // Conseil vocal
                GestureDetector(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).push(fadeRoute( VoiceListeningScreen(actionType: widget.actionType)));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: _primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: _primary.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.mic_rounded,
                          color: _primary,
                          size: 20,
                        ),
                        SizedBox(width: 12.w),
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
                              const SizedBox(height: 2),
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
                const SizedBox(height: 20),

                // Titre
                Label('TITRE DE LA TÂCHE'),
                const SizedBox(height: 6),
                BlocBuilder<FormTastBloc, CreateTastState>(
                  builder: (context, state) {
                    return TextFormField(
                      controller: _controllerTitle,
                      readOnly: state.status.isInProgress,
                      errorBuilder: (context, error) {
                        return Text(
                          error,
                          style: GoogleFonts.roboto(
                            color: Colors.red,
                            fontSize: 12.sp,
                          ),
                        );
                      },
                      forceErrorText:
                          !state.title.isPure || !state.title.isValid
                          ? 'Se champs est obligatoirre'
                          : '',
                      onChanged: (_) {
                        context.read<FormTastBloc>().add(
                          CreateTaskEvent.changeTitle(_controllerTitle.text),
                        );
                      },
                      style: GoogleFonts.roboto(
                        color: Color(0xFF1A1A2E),
                        fontSize: 15.h,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Ex : Appeler Jean...',
                        hintStyle: GoogleFonts.roboto(color: Color(0xFF6B7280)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.h,
                          vertical: 14.h,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 14.h),

                // Date + Heure
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Label('DATE'),
                          const SizedBox(height: 6),
                          GestureDetector(
                            onTap: _pickDate,
                            child: FieldBox(
                              icon: Icons.calendar_today_rounded,
                              text: _controllerDate.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Label('HEURE'),
                          const SizedBox(height: 6),
                          GestureDetector(
                            onTap: _pickTime,
                            child: FieldBox(
                              icon: Icons.access_time_rounded,
                              text: _controllerTime.text,
                              // format(context)
                              // _controllerTime.text,
                              // _time.format(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Répétition
                Label('DESCRIPTION'),
                const SizedBox(height: 6),
                BlocBuilder<FormTastBloc, CreateTastState>(
                  builder: (context, state) {
                    return TextFormField(
                      controller: _controllerContent,
                      readOnly: state.status.isInProgress,
                      forceErrorText:
                          !state.content.isPure || !state.content.isValid
                          ? 'Se champs est obligatoirre'
                          : '',
                      maxLines: 4,
                      onChanged: (value) {
                        context.read<FormTastBloc>().add(
                          CreateTaskEvent.changeContent(
                            _controllerContent.text,
                          ),
                        );
                      },
                      style: GoogleFonts.roboto(
                        color: const Color(0xFF1A1A2E),
                        fontSize: 14.sp,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Ex : Description',
                        hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 25.h),

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
                        colorText: Colors.white,
                        backgroundColor: state.status.isInProgress
                            ? _primary.withValues(alpha: 0.4)
                            : _primary,
                        borderRadius: 16,
                        onPressed: state.status.isInProgress || !state.isValide
                            ? null
                            : () {
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SuccessScreen(),
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
  );
}
