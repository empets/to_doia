import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/constante/app_colors.dart';
import 'package:grace_church/core/injetction/injection_container.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/core/service_systeme/usercase/usercase.dart';
import 'package:grace_church/feature/auth/domaine/entities/utilisateur_entite.dart';
import 'package:grace_church/feature/auth/domaine/usecase/surveiller_utilisateur_usecase.dart';

/// Bannière de compte affichée dans les paramètres.
///
/// Affiche le nom et l'e-mail de l'utilisateur connecté, ou une invitation à se
/// connecter. Elle se met à jour automatiquement après connexion/déconnexion.
class CompteBanniere extends StatefulWidget {
  const CompteBanniere({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  State<CompteBanniere> createState() => _CompteBanniereState();
}

class _CompteBanniereState extends State<CompteBanniere> {
  late final Stream<Either<Failure, UtilisateurEntite?>> _utilisateur;

  @override
  void initState() {
    super.initState();
    _utilisateur = getIt<SurveillerUtilisateurUseCase>()(EmptyRequest());
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
    stream: _utilisateur,
    builder: (context, snapshot) {
      UtilisateurEntite? utilisateur;
      final resultat = snapshot.data;
      if (resultat != null) {
        resultat.fold((_) {}, (valeur) => utilisateur = valeur);
      }

      final connecte = utilisateur != null;
      final titre = connecte ? utilisateur!.nomAfficheOuEmail : 'Mon compte';
      final sousTitre = connecte
          ? utilisateur!.email
          : 'Connexion et inscription';
      final initiale = connecte && titre.isNotEmpty
          ? titre.substring(0, 1).toUpperCase()
          : null;

      return GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primaryLight, AppColors.primary],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 52.w,
                    height: 52.h,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: initiale != null
                          ? Text(
                              initiale,
                              style: GoogleFonts.roboto(
                                color: AppColors.white,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                          : Text(
                              '👤',
                              style: GoogleFonts.roboto(fontSize: 26.sp),
                            ),
                    ),
                  ),
                  if (connecte)
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        width: 18.w,
                        height: 18.w,
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: AppColors.white,
                          size: 11,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        color: AppColors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      sousTitre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        color: Colors.white70,
                        fontSize: 12.sp,
                      ),
                    ),
                    if (connecte) ...[
                      SizedBox(height: 6.h),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Connecté',
                          style: GoogleFonts.roboto(
                            color: AppColors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.white.withValues(alpha: 0.9),
              ),
            ],
          ),
        ),
      );
    },
  );
}
