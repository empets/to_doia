// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grace_church/feature/assistant/app_bar_ia.dart';
import 'package:grace_church/feature/assistant/shara_loading_button.dart'
    show SharaMicButton;
import 'package:grace_church/feature/home/presentation/widget/chart_whithe_grace.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/constante/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  final void Function(String) onRoute;
  final bool notifOn;
  final void Function(bool) onToggleNotif;
  final bool soundOn;
  final void Function(bool) onToggleSound;
  final bool vibOn;
  final void Function(bool) onToggleVib;
  final bool confirmCreate;
  final void Function(bool) onToggleConfirmCreate;

  const SettingsScreen({
    super.key,
    required this.onRoute,
    required this.notifOn,
    required this.onToggleNotif,
    required this.soundOn,
    required this.onToggleSound,
    required this.vibOn,
    required this.onToggleVib,
    required this.confirmCreate,
    required this.onToggleConfirmCreate,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // L'état du micro vient de [SharaNavigationBloc] (voir le FAB plus bas).

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: SharaAppBar(),
    backgroundColor: AppColors.background,
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              'Paramètres',
              style: GoogleFonts.roboto(
                color: AppColors.ink,
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          // Bannière profil
          Container(
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
                Container(
                  width: 52.w,
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text('👤', style: GoogleFonts.roboto(fontSize: 26.sp)),
                  ),
                ),
                SizedBox(width: 14.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Utilisateur',
                      style: GoogleFonts.roboto(
                        color: AppColors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Version 1.0.0',
                      style: GoogleFonts.roboto(color: Colors.white70, fontSize: 12.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),

          _SGroup(
            title: 'Général',
            children: [
              _STile(
                icon: Icons.palette_rounded,
                bg: AppColors.primary,
                label: 'Apparence',
                sub: 'Clair',
                onTap: () => widget.onRoute('appearance'),
              ),
              _STile(
                icon: Icons.language_rounded,
                bg: AppColors.success,
                label: 'Langue',
                sub: 'Français',
                onTap: () => widget.onRoute('language'),
              ),
              _STile(
                icon: Icons.access_time_rounded,
                bg: AppColors.warning,
                label: "Format de l'heure",
                sub: '24 heures',
              ),
              _STile(
                icon: Icons.calendar_month_rounded,
                bg: AppColors.pink,
                label: 'Premier jour de la semaine',
                sub: 'Lundi',
                last: true,
              ),
            ],
          ),

          _SGroup(
            title: 'Notifications',
            children: [
              _STile(
                icon: Icons.notifications_rounded,
                bg: AppColors.error,
                label: 'Notifications',
                onTap: () => widget.onRoute('notifications'),
                trailing: _Switch(
                  value: widget.notifOn,
                  onChanged: widget.onToggleNotif,
                ),
              ),
              _STile(
                icon: Icons.volume_up_rounded,
                bg: AppColors.purple,
                label: 'Son',
                trailing: _Switch(
                  value: widget.soundOn,
                  onChanged: widget.onToggleSound,
                ),
              ),
              _STile(
                icon: Icons.vibration_rounded,
                bg: AppColors.cyan,
                label: 'Vibration',
                last: true,
                trailing: _Switch(
                  value: widget.vibOn,
                  onChanged: widget.onToggleVib,
                ),
              ),
            ],
          ),

          _SGroup(
            title: 'Voix et IA',
            children: [
              _STile(
                icon: Icons.mic_rounded,
                bg: AppColors.primary,
                label: 'Voix et IA',
                sub: 'Français',
                onTap: () => widget.onRoute('voice'),
              ),
              _STile(
                icon: Icons.check_circle_rounded,
                bg: AppColors.success,
                label: 'Confirmer avant création',
                last: true,
                trailing: _Switch(
                  value: widget.confirmCreate,
                  onChanged: widget.onToggleConfirmCreate,
                ),
              ),
            ],
          ),

          _SGroup(
            title: 'Tâches',
            children: [
              _STile(
                icon: Icons.sort_rounded,
                bg: AppColors.warning,
                label: 'Trier par',
                sub: 'Date',
              ),
              _STile(
                icon: Icons.visibility_rounded,
                bg: AppColors.primary,
                label: 'Afficher les terminées',
                trailing: _Switch(value: true, onChanged: (_) {}),
              ),
              _STile(
                icon: Icons.delete_outline_rounded,
                bg: AppColors.error,
                label: 'Confirmer avant suppression',
                last: true,
                trailing: _Switch(value: true, onChanged: (_) {}),
              ),
            ],
          ),

          _SGroup(
            title: 'Données',
            children: [
              _STile(
                icon: Icons.history_rounded,
                bg: AppColors.purple,
                label: 'Historique',
              ),
              _STile(
                icon: Icons.upload_rounded,
                bg: AppColors.success,
                label: 'Exporter les tâches',
              ),
              _STile(
                icon: Icons.download_rounded,
                bg: AppColors.cyan,
                label: 'Importer les tâches',
                onTap: () => widget.onRoute('data'),
              ),
              _STile(
                icon: Icons.delete_forever_rounded,
                bg: AppColors.error,
                label: 'Supprimer toutes les données',
                last: true,
                onTap: () => widget.onRoute('data'),
              ),
            ],
          ),

          _SGroup(
            title: 'Application',
            children: [
              _STile(
                icon: Icons.info_outline_rounded,
                bg: AppColors.primary,
                label: 'À propos',
                sub: 'Version 1.0.0',
                onTap: () => widget.onRoute('about'),
              ),
              _STile(
                icon: Icons.help_outline_rounded,
                bg: AppColors.success,
                label: 'Aide',
                onTap: () => widget.onRoute('help'),
              ),
              _STile(
                icon: Icons.feedback_outlined,
                bg: AppColors.warning,
                label: 'Envoyer un retour',
              ),
              _STile(
                icon: Icons.privacy_tip_outlined,
                bg: AppColors.purple,
                label: 'Politique de confidentialité',
                last: true,
              ),
            ],
          ),

          SizedBox(height: 32.h),
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
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  );
}

class _SGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SGroup({required this.title, required this.children});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(2, 20, 2, 8),
        child: Text(
          title.toUpperCase(),
          style: GoogleFonts.roboto(
            color: AppColors.greyText,
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: AppColors.black.withOpacity(0.04), blurRadius: 8),
          ],
        ),
        child: Column(children: children),
      ),
    ],
  );
}

class _STile extends StatelessWidget {
  final IconData icon;
  final Color bg;
  final String label;
  final String? sub;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool last;
  const _STile({
    required this.icon,
    required this.bg,
    required this.label,
    this.sub,
    this.trailing,
    this.onTap,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(bottom: BorderSide(color: AppColors.greyOverlay)),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.white, size: 18),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.roboto(
                    color: AppColors.ink,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (sub != null)
                  Text(
                    sub!,
                    style: GoogleFonts.roboto(
                      color: AppColors.greyText,
                      fontSize: 12.sp,
                    ),
                  ),
              ],
            ),
          ),
          trailing ??
              (onTap != null
                  ? const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.greyText,
                      size: 20,
                    )
                  : const SizedBox()),
        ],
      ),
    ),
  );
}

class _Switch extends StatelessWidget {
  final bool value;
  final void Function(bool) onChanged;
  const _Switch({required this.value, required this.onChanged});
  @override
  Widget build(BuildContext context) => Switch(
    value: value,
    onChanged: onChanged,
    activeThumbColor: AppColors.primary,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}
