import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/constante/app_colors.dart';
import 'package:grace_church/core/injetction/injection_container.dart';
import 'package:grace_church/core/navigation/shara_route.dart';
import 'package:grace_church/feature/auth/domaine/entities/utilisateur_entite.dart';
import 'package:grace_church/feature/auth/domaine/usecase/connecter_utilisateur_usecase.dart';
import 'package:grace_church/feature/auth/domaine/usecase/deconnecter_utilisateur_usecase.dart';
import 'package:grace_church/feature/auth/domaine/usecase/inscrire_utilisateur_usecase.dart';
import 'package:grace_church/feature/auth/domaine/usecase/utilisateur_courant_usecase.dart';
import 'package:grace_church/feature/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:grace_church/feature/auth/presentation/bloc/auth/event/auth_event.dart';
import 'package:grace_church/feature/auth/presentation/bloc/auth/state/auth_state.dart';

const _primary = AppColors.primary;
const _sub = AppColors.greyText;
const _tx = AppColors.ink;

/// Écran d'authentification : connexion, création de compte et déconnexion.
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key, this.sansRetour = false});

  /// En flow premier lancement (après permissions) : pas de bouton retour.
  final bool sansRetour;

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: !sansRetour,
    onPopInvokedWithResult: (didPop, result) {},
    child: BlocProvider(
      create: (_) => AuthBloc(
        connecter: getIt<ConnecterUtilisateurUseCase>(),
        inscrire: getIt<InscrireUtilisateurUseCase>(),
        deconnecter: getIt<DeconnecterUtilisateurUseCase>(),
        utilisateurCourant: getIt<UtilisateurCourantUseCase>(),
      )..add(AuthEvent.sessionVerifiee()),
      child: const _AuthView(),
    ),
  );
}

class _AuthView extends StatefulWidget {
  const _AuthView();

  @override
  State<_AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<_AuthView> {
  final _nomCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _motDePasseCtrl = TextEditingController();
  final _confirmationCtrl = TextEditingController();
  bool _voirMotDePasse = false;
  bool _voirConfirmation = false;

  @override
  void dispose() {
    _nomCtrl.dispose();
    _emailCtrl.dispose();
    _motDePasseCtrl.dispose();
    _confirmationCtrl.dispose();
    super.dispose();
  }

  void _snack(String message, {required Color backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.roboto()),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
      ),
    );
  }

  void _basculerMode(ModeAuthentification mode) {
    _nomCtrl.clear();
    _motDePasseCtrl.clear();
    _confirmationCtrl.clear();
    _voirMotDePasse = false;
    _voirConfirmation = false;
    context.read<AuthBloc>().add(AuthEvent.modeChanged(mode));
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthBloc, AuthState>(
    listenWhen: (previous, current) =>
        previous.status != current.status ||
        previous.errorMessage != current.errorMessage,
    listener: (context, state) {
      if (state.status == FormzSubmissionStatus.success) {
        final utilisateur = state.utilisateur;
        if (utilisateur == null) {
          _nomCtrl.clear();
          _emailCtrl.clear();
          _motDePasseCtrl.clear();
          _confirmationCtrl.clear();
          _voirMotDePasse = false;
          _voirConfirmation = false;
          _snack('Vous êtes déconnecté.', backgroundColor: AppColors.success);
          return;
        }
        // Le mot de passe ne doit pas rester en mémoire dans l'interface.
        _motDePasseCtrl.clear();
        _confirmationCtrl.clear();
        _voirMotDePasse = false;
        _voirConfirmation = false;
        _snack(
          state.mode == ModeAuthentification.inscription
              ? 'Compte créé. Bienvenue !'
              : 'Connexion réussie. Bienvenue !',
          backgroundColor: AppColors.success,
        );
        context.go(SharaRoute.home);
      } else if (state.status == FormzSubmissionStatus.failure &&
          state.errorMessage.isNotEmpty) {
        _snack(state.errorMessage, backgroundColor: AppColors.error);
      }
    },
    builder: (context, state) {
      if (!state.sessionVerifiee) {
        return const Center(child: CircularProgressIndicator(color: _primary));
      }

      final utilisateur = state.utilisateur;
      if (utilisateur != null) {
        return _Compte(
          utilisateur: utilisateur,
          enCours: state.status.isInProgress,
        );
      }

      return _formulaire(context, state);
    },
  );

  Widget _formulaire(BuildContext context, AuthState state) {
    final inscription = state.mode == ModeAuthentification.inscription;
    final enCours = state.status.isInProgress;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        SizedBox(height: 8.h),
        Center(
          child: Container(
            width: 76.w,
            height: 76.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primaryLight, AppColors.primary],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _primary.withValues(alpha: 0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.lock_outline_rounded,
              color: AppColors.white,
              size: 34,
            ),
          ),
        ),
        SizedBox(height: 18.h),
        Text(
          inscription ? 'Créer un compte' : 'Bienvenue',
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            color: _tx,
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          inscription
              ? 'Renseignez vos informations pour commencer.'
              : 'Connectez-vous avec votre adresse e-mail.',
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(color: _sub, fontSize: 12.sp, height: 1.5),
        ),
        SizedBox(height: 22.h),

        _SelecteurMode(
          mode: state.mode,
          onChanged: enCours ? null : _basculerMode,
        ),
        SizedBox(height: 20.h),

        if (inscription) ...[
          _Champ(
            label: 'Nom complet',
            controller: _nomCtrl,
            hint: 'Votre nom',
            icon: Icons.person_outline_rounded,
            textInputAction: TextInputAction.next,
            error: state.nom.displayError == null
                ? null
                : 'Indiquez votre nom.',
            onChanged: (value) =>
                context.read<AuthBloc>().add(AuthEvent.nomChanged(value)),
          ),
          SizedBox(height: 14.h),
        ],

        _Champ(
          label: 'Adresse e-mail',
          controller: _emailCtrl,
          hint: 'vous@exemple.com',
          icon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          error: state.email.displayError == null
              ? null
              : 'Adresse e-mail invalide.',
          onChanged: (value) =>
              context.read<AuthBloc>().add(AuthEvent.emailChanged(value)),
        ),
        SizedBox(height: 14.h),

        _Champ(
          label: 'Mot de passe',
          controller: _motDePasseCtrl,
          hint: '8 caractères minimum',
          icon: Icons.lock_outline_rounded,
          obscureText: !_voirMotDePasse,
          textInputAction: inscription
              ? TextInputAction.next
              : TextInputAction.done,
          error: state.motDePasse.displayError == null
              ? null
              : 'Le mot de passe doit contenir au moins 8 caractères.',
          onChanged: (value) =>
              context.read<AuthBloc>().add(AuthEvent.motDePasseChanged(value)),
          suffixIcon: IconButton(
            onPressed: () => setState(() => _voirMotDePasse = !_voirMotDePasse),
            icon: Icon(
              _voirMotDePasse
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: _sub,
              size: 20,
            ),
          ),
        ),

        if (inscription) ...[
          SizedBox(height: 14.h),
          _Champ(
            label: 'Confirmer le mot de passe',
            controller: _confirmationCtrl,
            hint: 'Répétez le mot de passe',
            icon: Icons.lock_reset_rounded,
            obscureText: !_voirConfirmation,
            textInputAction: TextInputAction.done,
            error: switch (state.confirmation.displayError) {
              null => null,
              _ when state.confirmation.value.isEmpty =>
                'Confirmez le mot de passe.',
              _ => 'Les mots de passe ne correspondent pas.',
            },
            onChanged: (value) => context.read<AuthBloc>().add(
              AuthEvent.confirmationChanged(value),
            ),
            suffixIcon: IconButton(
              onPressed: () =>
                  setState(() => _voirConfirmation = !_voirConfirmation),
              icon: Icon(
                _voirConfirmation
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: _sub,
                size: 20,
              ),
            ),
          ),
        ],

        if (state.errorMessage.isNotEmpty) ...[
          SizedBox(height: 16.h),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.error.withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  color: AppColors.error,
                  size: 18,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    state.errorMessage,
                    style: GoogleFonts.roboto(
                      color: AppColors.error,
                      fontSize: 12.sp,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],

        SizedBox(height: 22.h),
        ElevatedButton(
          onPressed: enCours || !state.isValide
              ? null
              : () {
                  FocusScope.of(context).unfocus();
                  context.read<AuthBloc>().add(AuthEvent.soumis());
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: _primary,
            foregroundColor: AppColors.white,
            disabledBackgroundColor: _primary.withValues(alpha: 0.45),
            disabledForegroundColor: AppColors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: enCours
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.white,
                  ),
                )
              : Text(
                  state.mode.actionLibelle,
                  style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
        SizedBox(height: 14.h),
        Text(
          inscription
              ? 'En créant un compte, vous acceptez notre politique de '
                    'confidentialité.'
              : 'Votre session reste active sur cet appareil.',
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(color: _sub, fontSize: 11.sp, height: 1.5),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}

class _SelecteurMode extends StatelessWidget {
  const _SelecteurMode({required this.mode, required this.onChanged});

  final ModeAuthentification mode;
  final ValueChanged<ModeAuthentification>? onChanged;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: AppColors.backgroundAlt2,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: AppColors.border),
    ),
    child: Row(
      children: [
        for (final valeur in ModeAuthentification.values)
          Expanded(
            child: GestureDetector(
              onTap: onChanged == null ? null : () => onChanged!(valeur),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: valeur == mode
                      ? AppColors.white
                      : AppColors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: valeur == mode
                      ? [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  valeur.libelle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: valeur == mode ? _primary : _sub,
                    fontSize: 13.sp,
                    fontWeight: valeur == mode
                        ? FontWeight.w700
                        : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

class _Champ extends StatelessWidget {
  const _Champ({
    required this.label,
    required this.controller,
    required this.hint,
    required this.icon,
    required this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.textInputAction,
    this.error,
    this.suffixIcon,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final String? error;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GoogleFonts.roboto(
          color: _tx,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 7.h),
      Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: error == null ? AppColors.border : AppColors.error,
          ),
        ),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          textInputAction: textInputAction,
          onChanged: onChanged,
          style: GoogleFonts.roboto(color: _tx, fontSize: 14.sp),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.roboto(color: _sub, fontSize: 13.sp),
            prefixIcon: Icon(icon, color: _sub, size: 19),
            suffixIcon: suffixIcon,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
      if (error != null) ...[
        SizedBox(height: 6.h),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            error!,
            style: GoogleFonts.roboto(color: AppColors.error, fontSize: 11.sp),
          ),
        ),
      ],
    ],
  );
}

/// Vue affichée quand un utilisateur est connecté.
class _Compte extends StatelessWidget {
  const _Compte({required this.utilisateur, required this.enCours});

  final UtilisateurEntite utilisateur;
  final bool enCours;

  @override
  Widget build(BuildContext context) {
    final initiale = utilisateur.nomAfficheOuEmail.isEmpty
        ? '?'
        : utilisateur.nomAfficheOuEmail.substring(0, 1).toUpperCase();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        SizedBox(height: 8.h),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primaryLight, AppColors.primary],
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              Container(
                width: 58.w,
                height: 58.h,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.22),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    initiale,
                    style: GoogleFonts.roboto(
                      color: AppColors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      utilisateur.nomAfficheOuEmail,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        color: AppColors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      utilisateur.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        color: Colors.white70,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            utilisateur.emailVerifie
                                ? Icons.verified_rounded
                                : Icons.info_outline_rounded,
                            color: AppColors.white,
                            size: 13,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            utilisateur.emailVerifie
                                ? 'E-mail vérifié'
                                : 'E-mail non vérifié',
                            style: GoogleFonts.roboto(
                              color: AppColors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 18.h),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.cloud_done_outlined,
                  color: AppColors.success,
                  size: 20,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Compte synchronisé',
                      style: GoogleFonts.roboto(
                        color: _tx,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Votre session Firebase est active sur cet appareil.',
                      style: GoogleFonts.roboto(
                        color: _sub,
                        fontSize: 11.sp,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        OutlinedButton.icon(
          onPressed: enCours
              ? null
              : () {
                  FocusScope.of(context).unfocus();
                  context.read<AuthBloc>().add(AuthEvent.deconnexionDemandee());
                },
          icon: enCours
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.logout_rounded, size: 18),
          label: Text(
            enCours ? 'Déconnexion...' : 'Se déconnecter',
            style: GoogleFonts.roboto(fontWeight: FontWeight.w700),
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.error,
            side: BorderSide(color: AppColors.error.withValues(alpha: 0.4)),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }
}
