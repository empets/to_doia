// lib/screens/confirmation_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/alert/app_alerte.dart';
import 'package:grace_church/core/custome_widget/button.dart';
import 'package:grace_church/core/extention/app_extention.dart';
import 'package:grace_church/core/injetction/injection_container.dart';
import 'package:grace_church/core/succes_screen/success_screen.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/home/domaine/usecase/create_task_usecase.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/create_task_bloc.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/event/create_tast_event.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/state/create_tast_state.dart';
import 'package:grace_church/feature/taches/presentation/pages/manual_create_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key, required this.task});

  final TaskResponse task;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: BlocProvider(
      create: (context) =>
          FormTastBloc(createTaskUseCase: getIt<CreateTaskUseCase>()),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête
              SizedBox(height: 17.h),
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.edit_notifications_outlined,
                      color: Color(0xFF6366F1),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Nouveau rappel',
                    style: GoogleFonts.roboto(
                      color: Color(0xFF6B7280),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Carte de la tâche
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: GoogleFonts.roboto(
                        color: Color(0xFF1A1A2E),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    Text(
                      task.content,
                      style: GoogleFonts.roboto(
                        color: Colors.grey.shade600,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 19.h),
                    Row(
                      children: [
                        Icon(
                          Icons.event_note,
                          size: 16.h,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(width: 8.w),
                        RichText(
                          text: TextSpan(
                            children: [
                              if (task.date.isNotEmpty)
                                TextSpan(
                                  text: formatDate(DateTime.parse(task.date)),
                                  style: GoogleFonts.roboto(
                                    color: Colors.grey.shade600,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              if (task.time.isNotEmpty)
                                TextSpan(
                                  text: ' à ${task.time}',
                                  style: GoogleFonts.roboto(
                                    color: Colors.grey.shade600,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timelapse,
                          size: 16.h,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w600,
                        ),

                        SizedBox(width: 8.w),
                        Text(
                          'A venir',
                          style: GoogleFonts.roboto(
                            color: Colors.grey.shade600,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Boutons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        //onModify
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ManualCreateScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF6366F1),
                        side: const BorderSide(
                          color: Color(0xFF6366F1),
                          width: 2,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Modifier',
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: BlocConsumer<FormTastBloc, CreateTastState>(
                      listener: (context, state) {
                        if (state.status.isSuccess) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SuccessScreen(),
                            ),
                          );
                        }
                        if (state.status.isFailure) {
                          AppAlert.showError(
                            context,
                            state.errorMessage ?? 'Une erreur est survenue',
                          );
                        }
                      },
                      builder: (context, state) {
                        return PrimaryButton(
                          label: "Confirmer",
                          fontSize: 14.sp,
                          colorText: Colors.white,
                          backgroundColor: const Color(0xFF6366F1),
                          borderRadius: 16,
                          isLoading: state.status.isInProgress,
                          onPressed: () {
                            context.read<FormTastBloc>().add(
                              CreateTaskEvent.changeTitle(task.title),
                            );
                            context.read<FormTastBloc>().add(
                              CreateTaskEvent.changeTime("02:00"),
                            );
                            context.read<FormTastBloc>().add(
                              CreateTaskEvent.changeTaskId("1"),
                            );
                            context.read<FormTastBloc>().add(
                              CreateTaskEvent.changeStatus(task.status),
                            );
                            context.read<FormTastBloc>().add(
                              CreateTaskEvent.changeRecurring(false),
                            );
                            context.read<FormTastBloc>().add(
                              CreateTaskEvent.changeDate(task.date),
                            );
                            context.read<FormTastBloc>().add(
                              CreateTaskEvent.changeContent(task.content),
                            );
                            context.read<FormTastBloc>().add(
                              CreateTaskEvent.submit(),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    //onCancel
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Annuler',
                    style: GoogleFonts.roboto(
                      color: Color(0xFFEF4444),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
