// lib/screens/confirmation_screen.dart
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/alert/app_alerte.dart';
import 'package:grace_church/core/custome_widget/button.dart';
import 'package:grace_church/core/extention/app_extention.dart';
import 'package:grace_church/core/navigation/shara_nav.dart';
import 'package:grace_church/core/succes_screen/success_screen.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/create_or_update_task_bloc.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/event/create_tast_event.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/state/create_tast_state.dart';
import 'package:grace_church/feature/taches/presentation/pages/manual_create_screen.dart';
import 'package:grace_church/core/constante/app_colors.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({
    super.key,
    required this.task,
    required this.actionType,
    this.onSuccess,
    this.onModify,
    this.onCancel,
  });

  final TaskResponse task;
  final String actionType;

  /// Si fournis : navigation pilotée par l'AppShell au lieu de Navigator.
  final VoidCallback? onSuccess;
  final VoidCallback? onModify;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    log('Recording time ${task.recordtime}');
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête
              SizedBox(height: 1.7.h),
              Row(
                children: [
                  Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.edit_notifications_outlined,
                      color: AppColors.primary,
                      size: 18,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Nouveau rappel',
                    style: GoogleFonts.roboto(
                      color: AppColors.greyText,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // Carte de la tâche
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.08),
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
                        color: AppColors.ink,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    Text(
                      task.content,
                      style: GoogleFonts.roboto(
                        color: AppColors.grey.shade600,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 1.9.h),
                    Row(
                      children: [
                        Icon(
                          Icons.event_note,
                          size: 16.h,
                          color: AppColors.grey.shade400,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(width: 8.w),
                        RichText(
                          text: TextSpan(
                            children: [
                              if (task.date.isNotEmpty)
                                TextSpan(
                                  text: formatDateString(task.date),
                                  style: GoogleFonts.roboto(
                                    color: AppColors.grey.shade600,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              if (task.time.isNotEmpty)
                                TextSpan(
                                  text: ' à ${task.time}',
                                  style: GoogleFonts.roboto(
                                    color: AppColors.grey.shade600,
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
                          color: AppColors.grey.shade400,
                          fontWeight: FontWeight.w600,
                        ),

                        SizedBox(width: 8.w),
                        Text(
                          'A venir',
                          style: GoogleFonts.roboto(
                            color: AppColors.grey.shade600,
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
                        if (onModify != null) {
                          onModify!();
                        } else {
                          // Défaut (standalone) : modification via le
                          // routeur avec la tâche pré-remplie.
                          SharaNav.modifyTask(task);
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: BorderSide(
                          color: AppColors.primary,
                          width: 2.w,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Modifier',
                        style: GoogleFonts.roboto(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: BlocConsumer<FormTastBloc, CreateTastState>(
                      listener: (context, state) {
                        if (state.status.isSuccess) {
                          if (onSuccess != null) {
                            onSuccess!();
                          } else {
                            // Défaut (standalone) : succès via le routeur.
                            SharaNav.taskConfirmed();
                          }
                        }
                        if (state.status.isFailure) {
                          AppAlert.showError(context, state.errorMessage);
                        }
                      },
                      builder: (context, state) {
                        return PrimaryButton(
                          label: "Confirmer",
                          fontSize: 14.sp,
                          colorText: AppColors.white,
                          backgroundColor: AppColors.primary,
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
                              CreateTaskEvent.actionType(actionType),
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
              SizedBox(height: 1.0.h),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    if (onCancel != null) {
                      onCancel!();
                    } else {
                      // Défaut (standalone) : retour accueil via le routeur.
                      SharaNav.navigate('home');
                    }
                  },
                  child: Text(
                    'Annuler',
                    style: GoogleFonts.roboto(
                      color: AppColors.error,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
