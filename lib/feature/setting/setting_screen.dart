// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grace_church/feature/assistant/app_bar_ia.dart';
import 'package:grace_church/feature/assistant/shara_loading_button.dart'
    show SharaMicButton;
import 'package:grace_church/feature/home/presentation/widget/chart_whithe_grace.dart';

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
  late bool isListening = false;

  late bool isLoad = false;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: SharaAppBar(),
    backgroundColor: const Color(0xFFF4F6FB),
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: const Text(
              'Paramètres',
              style: TextStyle(
                color: Color(0xFF1A1A2E),
                fontSize: 24,
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
                colors: [Color(0xFF818CF8), Color(0xFF6366F1)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text('👤', style: TextStyle(fontSize: 26)),
                  ),
                ),
                const SizedBox(width: 14),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Utilisateur',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
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
                bg: const Color(0xFF6366F1),
                label: 'Apparence',
                sub: 'Clair',
                onTap: () => widget.onRoute('appearance'),
              ),
              _STile(
                icon: Icons.language_rounded,
                bg: const Color(0xFF10B981),
                label: 'Langue',
                sub: 'Français',
                onTap: () => widget.onRoute('language'),
              ),
              _STile(
                icon: Icons.access_time_rounded,
                bg: const Color(0xFFF59E0B),
                label: "Format de l'heure",
                sub: '24 heures',
              ),
              _STile(
                icon: Icons.calendar_month_rounded,
                bg: const Color(0xFFEC4899),
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
                bg: const Color(0xFFEF4444),
                label: 'Notifications',
                onTap: () => widget.onRoute('notifications'),
                trailing: _Switch(
                  value: widget.notifOn,
                  onChanged: widget.onToggleNotif,
                ),
              ),
              _STile(
                icon: Icons.volume_up_rounded,
                bg: const Color(0xFF8B5CF6),
                label: 'Son',
                trailing: _Switch(
                  value: widget.soundOn,
                  onChanged: widget.onToggleSound,
                ),
              ),
              _STile(
                icon: Icons.vibration_rounded,
                bg: const Color(0xFF06B6D4),
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
                bg: const Color(0xFF6366F1),
                label: 'Voix et IA',
                sub: 'Français',
                onTap: () => widget.onRoute('voice'),
              ),
              _STile(
                icon: Icons.check_circle_rounded,
                bg: const Color(0xFF10B981),
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
                bg: const Color(0xFFF59E0B),
                label: 'Trier par',
                sub: 'Date',
              ),
              _STile(
                icon: Icons.visibility_rounded,
                bg: const Color(0xFF6366F1),
                label: 'Afficher les terminées',
                trailing: _Switch(value: true, onChanged: (_) {}),
              ),
              _STile(
                icon: Icons.delete_outline_rounded,
                bg: const Color(0xFFEF4444),
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
                bg: const Color(0xFF8B5CF6),
                label: 'Historique',
              ),
              _STile(
                icon: Icons.upload_rounded,
                bg: const Color(0xFF10B981),
                label: 'Exporter les tâches',
              ),
              _STile(
                icon: Icons.download_rounded,
                bg: const Color(0xFF06B6D4),
                label: 'Importer les tâches',
                onTap: () => widget.onRoute('data'),
              ),
              _STile(
                icon: Icons.delete_forever_rounded,
                bg: const Color(0xFFEF4444),
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
                bg: const Color(0xFF6366F1),
                label: 'À propos',
                sub: 'Version 1.0.0',
                onTap: () => widget.onRoute('about'),
              ),
              _STile(
                icon: Icons.help_outline_rounded,
                bg: const Color(0xFF10B981),
                label: 'Aide',
                onTap: () => widget.onRoute('help'),
              ),
              _STile(
                icon: Icons.feedback_outlined,
                bg: const Color(0xFFF59E0B),
                label: 'Envoyer un retour',
              ),
              _STile(
                icon: Icons.privacy_tip_outlined,
                bg: const Color(0xFF8B5CF6),
                label: 'Politique de confidentialité',
                last: true,
              ),
            ],
          ),

          const SizedBox(height: 32),
        ],
      ),
    ),
    floatingActionButton:
        BlocConsumer<SharaNavigationBloc, SharaNavigationState>(
          listener: (context, state) {
            if (state is SharaNavigationLoading) {
              setState(() => isLoad = true);
            } else if (state is SharaNavigationSuccess) {
              setState(() => isLoad = false);
            } else if (state is SharaNavigationError) {
              setState(() => isLoad = false);
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            return SharaMicButton(
              isListening: isListening,
              isLoading: isLoad, // ou state is LoadingState
              onPressed: () {
                setState(() => isListening = !isListening);
                context.read<SharaNavigationBloc>().add(
                  isListening ? SharaStopListening() : SharaStartListening(),
                );
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
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
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
            : const Border(bottom: BorderSide(color: Color(0x1A6B7280))),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF1A1A2E),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (sub != null)
                  Text(
                    sub!,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          trailing ??
              (onTap != null
                  ? const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF6B7280),
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
    activeThumbColor: const Color(0xFF6366F1),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}
