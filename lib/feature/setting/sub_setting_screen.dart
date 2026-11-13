// lib/screens/settings_sub_screens.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:grace_church/core/models/task.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/navigation/shara_nav.dart';
import 'package:grace_church/core/constante/app_colors.dart';
import 'package:grace_church/core/injetction/injection_container.dart';
import 'package:grace_church/feature/setting/domaine/entities/feedback_entite.dart';
import 'package:grace_church/feature/setting/domaine/usecase/envoyer_feedback_usecase.dart';
import 'package:grace_church/feature/setting/presentation/bloc/feedback/event/feedback_event.dart';
import 'package:grace_church/feature/setting/presentation/bloc/feedback/feedback_bloc.dart';
import 'package:grace_church/feature/setting/presentation/bloc/feedback/state/feedback_state.dart';

const _P = AppColors.primary;
const _sub = AppColors.greyText;
const _tx = AppColors.ink;

// ── Réutilisable ──────────────────────────────────────────────────────────────
class SubScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  const SubScaffold({super.key, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    appBar: AppBar(
      backgroundColor: AppColors.background,
      surfaceTintColor: AppColors.transparent,
      foregroundColor: _tx,
      elevation: 0,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      leading: GestureDetector(
        onTap: () => SharaNav.navigate('settings'),
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _P.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.chevron_left_rounded, color: _P),
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.roboto(
          color: _tx,
          fontSize: 17.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    body: body,
  );
}

// ─── 12. Apparence ────────────────────────────────────────────────────────────
class AppearanceScreen extends StatefulWidget {
  final String initialTheme;
  final void Function(String) onChanged;
  const AppearanceScreen({
    super.key,
    required this.initialTheme,
    required this.onChanged,
  });
  @override
  State<AppearanceScreen> createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends State<AppearanceScreen> {
  late String _theme;
  @override
  void initState() {
    super.initState();
    _theme = widget.initialTheme;
  }

  @override
  Widget build(BuildContext context) => SubScaffold(
    title: 'Apparence',
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Choisissez un thème',
          style: GoogleFonts.roboto(color: _sub, fontSize: 13.sp),
        ),
        SizedBox(height: 14.h),

        // Cartes de thème
        Row(
          children: [
            for (final t in [
              ('system', '🔄', 'Système'),
              ('light', '☀️', 'Clair'),
              ('dark', '🌙', 'Sombre'),
            ]) ...[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => _theme = t.$1);
                    widget.onChanged(t.$1);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _theme == t.$1 ? _P : AppColors.transparent,
                        width: 2.w,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.04),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(t.$2, style: GoogleFonts.roboto(fontSize: 28.sp)),
                        SizedBox(height: 8.h),
                        Text(
                          t.$3,
                          style: GoogleFonts.roboto(
                            color: _theme == t.$1 ? _P : _sub,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (_theme == t.$1) ...[
                          SizedBox(height: 4.h),
                          const Icon(Icons.check_rounded, color: _P, size: 16),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              if (t.$1 != 'dark') SizedBox(width: 10.w),
            ],
          ],
        ),
        SizedBox(height: 24.h),

        Text(
          'Aperçu',
          style: GoogleFonts.roboto(color: _sub, fontSize: 13.sp),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _P.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Smart Reminder',
                style: GoogleFonts.roboto(
                  color: _P,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Bonjour 👋',
                style: GoogleFonts.roboto(color: _tx, fontSize: 14.sp),
              ),
              SizedBox(height: 8.h),
              Container(
                height: 8.h,
                width: 110.w,
                decoration: BoxDecoration(
                  color: _P.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─── 13. Langue ───────────────────────────────────────────────────────────────
class LanguageScreen extends StatefulWidget {
  final String appLang, voiceLang;
  final void Function(String) onAppLang, onVoiceLang;
  const LanguageScreen({
    super.key,
    required this.appLang,
    required this.voiceLang,
    required this.onAppLang,
    required this.onVoiceLang,
  });
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late String _app, _voice;
  @override
  void initState() {
    super.initState();
    _app = widget.appLang;
    _voice = widget.voiceLang;
  }

  @override
  Widget build(BuildContext context) => SubScaffold(
    title: 'Langue',
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _choiceGroup(
          title: "Langue de l'application",
          opts: [('Français', '🇫🇷'), ('English', '🇬🇧')],
          value: _app,
          onSelect: (v) {
            setState(() => _app = v);
            widget.onAppLang(v);
          },
        ),
        SizedBox(height: 24.h),
        _choiceGroup(
          title: 'Langue de reconnaissance vocale',
          opts: [
            ('Français', '🇫🇷'),
            ('English', '🇬🇧'),
            ('Détection automatique', '🌐'),
          ],
          value: _voice,
          onSelect: (v) {
            setState(() => _voice = v);
            widget.onVoiceLang(v);
          },
        ),
      ],
    ),
  );

  Widget _choiceGroup({
    required String title,
    required List<(String, String)> opts,
    required String value,
    required void Function(String) onSelect,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title.toUpperCase(),
        style: GoogleFonts.roboto(
          color: _sub,
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
      SizedBox(height: 10.h),
      Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: opts.asMap().entries.map((e) {
            final (label, flag) = e.value;
            return Column(
              children: [
                ListTile(
                  onTap: () => onSelect(label),
                  leading: Text(
                    flag,
                    style: GoogleFonts.roboto(fontSize: 22.sp),
                  ),
                  title: Text(
                    label,
                    style: GoogleFonts.roboto(
                      color: _tx,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: value == label
                      ? const Icon(Icons.check_rounded, color: _P, size: 20)
                      : null,
                ),
                if (e.key < opts.length - 1)
                  Divider(
                    height: 1.h,
                    indent: 56,
                    color: AppColors.greyOverlay,
                  ),
              ],
            );
          }).toList(),
        ),
      ),
    ],
  );
}

// ─── 14. Notifications ────────────────────────────────────────────────────────
class NotificationsSettingsScreen extends StatefulWidget {
  final bool notifOn, soundOn, vibOn;
  final void Function(bool) onNotif, onSound, onVib;
  final String lateReminder, reminderBefore;
  final void Function(String) onLate, onBefore;

  const NotificationsSettingsScreen({
    super.key,
    required this.notifOn,
    required this.soundOn,
    required this.vibOn,
    required this.onNotif,
    required this.onSound,
    required this.onVib,
    required this.lateReminder,
    required this.reminderBefore,
    required this.onLate,
    required this.onBefore,
  });
  @override
  State<NotificationsSettingsScreen> createState() => _NotifSettingsState();
}

class _NotifSettingsState extends State<NotificationsSettingsScreen> {
  late bool _notif, _sound, _vib;
  late String _late, _before;

  @override
  void initState() {
    super.initState();
    _notif = widget.notifOn;
    _sound = widget.soundOn;
    _vib = widget.vibOn;
    _late = widget.lateReminder;
    _before = widget.reminderBefore;
  }

  @override
  Widget build(BuildContext context) => SubScaffold(
    title: 'Notifications',
    body: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        _group('Général', [
          _row(
            Icons.notifications_rounded,
            AppColors.error,
            'Autoriser',
            Switch(
              value: _notif,
              onChanged: (v) {
                setState(() => _notif = v);
                widget.onNotif(v);
              },
              activeThumbColor: _P,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          _row(
            Icons.volume_up_rounded,
            AppColors.purple,
            'Son',
            Switch(
              value: _sound,
              onChanged: (v) {
                setState(() => _sound = v);
                widget.onSound(v);
              },
              activeThumbColor: _P,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          _row(
            Icons.vibration_rounded,
            AppColors.cyan,
            'Vibration',
            Switch(
              value: _vib,
              onChanged: (v) {
                setState(() => _vib = v);
                widget.onVib(v);
              },
              activeThumbColor: _P,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            last: true,
          ),
        ]),
        _choiceSection(
          'Rappels en retard',
          ['Ignorer', 'Notifier immédiatement', 'Reporter'],
          _late,
          (v) {
            setState(() => _late = v);
            widget.onLate(v);
          },
        ),
        _choiceSection(
          'Rappel avant',
          ['Aucun', '5 minutes', '10 minutes', '15 minutes', '30 minutes'],
          _before,
          (v) {
            setState(() => _before = v);
            widget.onBefore(v);
          },
        ),
        SizedBox(height: 32.h),
      ],
    ),
  );

  Widget _group(String title, List<Widget> children) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(2, 20, 2, 8),
        child: Text(
          title.toUpperCase(),
          style: GoogleFonts.roboto(
            color: _sub,
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
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(children: children),
      ),
    ],
  );

  Widget _row(
    IconData icon,
    Color bg,
    String label,
    Widget trailing, {
    bool last = false,
  }) => Container(
    decoration: BoxDecoration(
      border: last
          ? null
          : const Border(bottom: BorderSide(color: AppColors.greyOverlay)),
    ),
    child: ListTile(
      leading: Container(
        width: 36.w,
        height: 36.h,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.white, size: 18),
      ),
      title: Text(
        label,
        style: GoogleFonts.roboto(
          color: _tx,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing,
    ),
  );

  Widget _choiceSection(
    String title,
    List<String> opts,
    String value,
    void Function(String) onSelect,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(2, 20, 2, 8),
        child: Text(
          title.toUpperCase(),
          style: GoogleFonts.roboto(
            color: _sub,
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
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: opts
              .asMap()
              .entries
              .map(
                (e) => Column(
                  children: [
                    ListTile(
                      onTap: () => onSelect(e.value),
                      title: Text(
                        e.value,
                        style: GoogleFonts.roboto(color: _tx, fontSize: 15.sp),
                      ),
                      trailing: value == e.value
                          ? const Icon(Icons.check_rounded, color: _P, size: 20)
                          : null,
                    ),
                    if (e.key < opts.length - 1)
                      Divider(
                        height: 1.h,
                        indent: 16,
                        color: AppColors.greyOverlay,
                      ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    ],
  );
}

// ─── 15. Voix & IA ────────────────────────────────────────────────────────────
class VoiceAIScreen extends StatefulWidget {
  final bool confirmCreate;
  final void Function(bool) onConfirmCreate;
  const VoiceAIScreen({
    super.key,
    required this.confirmCreate,
    required this.onConfirmCreate,
  });
  @override
  State<VoiceAIScreen> createState() => _VoiceAIScreenState();
}

class _VoiceAIScreenState extends State<VoiceAIScreen> {
  late bool _confirm;
  @override
  void initState() {
    super.initState();
    _confirm = widget.confirmCreate;
  }

  @override
  Widget build(BuildContext context) => SubScaffold(
    title: 'Voix et IA',
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _group('Reconnaissance vocale', [
          _tile(
            Icons.language_rounded,
            AppColors.success,
            'Langue',
            sub: 'Français',
          ),
          _tile(
            Icons.auto_fix_high_rounded,
            AppColors.primary,
            'Fin de phrase automatique',
            trail: Switch(
              value: true,
              onChanged: (_) {},
              activeThumbColor: _P,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          _tile(
            Icons.subtitles_rounded,
            AppColors.purple,
            'Afficher la transcription',
            last: true,
            trail: Switch(
              value: true,
              onChanged: (_) {},
              activeThumbColor: _P,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ]),
        _group('Assistant IA', [
          _tile(
            Icons.check_circle_rounded,
            AppColors.success,
            'Confirmer avant création',
            trail: Switch(
              value: _confirm,
              onChanged: (v) {
                setState(() => _confirm = v);
                widget.onConfirmCreate(v);
              },
              activeThumbColor: _P,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          _tile(
            Icons.calendar_today_rounded,
            AppColors.warning,
            'Dates relatives',
            sub: '"Demain", "Dans 2 jours"...',
            trail: Switch(
              value: true,
              onChanged: (_) {},
              activeThumbColor: _P,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          _tile(
            Icons.repeat_rounded,
            AppColors.cyan,
            'Tâches récurrentes',
            sub: '"Tous les lundis"...',
            last: true,
            trail: Switch(
              value: true,
              onChanged: (_) {},
              activeThumbColor: _P,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ]),

        // Exemple
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _P.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _P.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.lightbulb_outline_rounded, color: _P, size: 16),
                  SizedBox(width: 8.w),
                  Text(
                    'Exemple',
                    style: GoogleFonts.roboto(
                      color: _P,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                '"Tous les lundis à 8h, rappelle-moi de faire mon rapport."',
                style: GoogleFonts.roboto(
                  color: _tx,
                  fontSize: 13.sp,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 12.h),
              for (final row in [
                ['📝', 'Faire mon rapport'],
                ['🔁', 'Chaque lundi'],
                ['🕐', '08:00'],
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Text(row[0], style: GoogleFonts.roboto(fontSize: 16.sp)),
                      SizedBox(width: 10.w),
                      Text(
                        row[1],
                        style: GoogleFonts.roboto(
                          color: _tx,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.mic_rounded, color: _P, size: 18),
          label: Text(
            'Tester le microphone',
            style: GoogleFonts.roboto(color: _P, fontWeight: FontWeight.w600),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: _P),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _group(String title, List<Widget> children) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(2, 20, 2, 8),
        child: Text(
          title.toUpperCase(),
          style: GoogleFonts.roboto(
            color: _sub,
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
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(children: children),
      ),
    ],
  );

  Widget _tile(
    IconData icon,
    Color bg,
    String label, {
    String? sub,
    Widget? trail,
    bool last = false,
  }) => Container(
    decoration: BoxDecoration(
      border: last
          ? null
          : const Border(bottom: BorderSide(color: AppColors.greyOverlay)),
    ),
    child: ListTile(
      leading: Container(
        width: 36.w,
        height: 36.h,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.white, size: 18),
      ),
      title: Text(
        label,
        style: GoogleFonts.roboto(
          color: _tx,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: sub != null
          ? Text(
              sub,
              style: GoogleFonts.roboto(color: _sub, fontSize: 12.sp),
            )
          : null,
      trailing:
          trail ??
          const Icon(Icons.chevron_right_rounded, color: _sub, size: 20),
    ),
  );
}

// ─── 16. Données ──────────────────────────────────────────────────────────────
class DataScreen extends StatefulWidget {
  final List<Task> tasks;
  final VoidCallback onDeleteAll;
  const DataScreen({super.key, required this.tasks, required this.onDeleteAll});
  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  bool _confirm = false;

  @override
  Widget build(BuildContext context) {
    final done = widget.tasks.where((t) => t.done).length;
    return SubScaffold(
      title: 'Données',
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Stats
          Row(
            children: [
              _statCard(
                '${widget.tasks.length}',
                'Tâches totales',
                AppColors.primary,
              ),
              SizedBox(width: 12.w),
              _statCard('$done', 'Terminées', AppColors.success),
            ],
          ),
          SizedBox(height: 24.h),

          // Actions
          _group([
            _tile(
              Icons.history_rounded,
              AppColors.purple,
              'Historique',
              'Tâches supprimées',
            ),
            _tile(
              Icons.upload_rounded,
              AppColors.success,
              'Exporter',
              'Format JSON',
            ),
            _tile(
              Icons.download_rounded,
              AppColors.cyan,
              'Importer',
              'Restaurer',
              last: true,
            ),
          ]),
          SizedBox(height: 20.h),

          // Zone danger
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _confirm ? _deleteConfirmCard() : _dangerCard(),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String value, String label, Color color) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.roboto(
              color: color,
              fontSize: 28.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.roboto(color: _sub, fontSize: 12.sp),
          ),
        ],
      ),
    ),
  );

  Widget _group(List<Widget> children) => Container(
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withValues(alpha: 0.04),
          blurRadius: 8,
        ),
      ],
    ),
    child: Column(children: children),
  );

  Widget _tile(
    IconData icon,
    Color bg,
    String label,
    String sub, {
    bool last = false,
  }) => Container(
    decoration: BoxDecoration(
      border: last
          ? null
          : const Border(bottom: BorderSide(color: AppColors.greyOverlay)),
    ),
    child: ListTile(
      leading: Container(
        width: 36.w,
        height: 36.h,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.white, size: 18),
      ),
      title: Text(
        label,
        style: GoogleFonts.roboto(
          color: _tx,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        sub,
        style: GoogleFonts.roboto(color: _sub, fontSize: 12.sp),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: _sub, size: 20),
    ),
  );

  Widget _dangerCard() => GestureDetector(
    onTap: () => setState(() => _confirm = true),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: AppColors.error,
                size: 20,
              ),
              SizedBox(width: 10.w),
              Text(
                'Zone de danger',
                style: GoogleFonts.roboto(
                  color: AppColors.error,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Divider(height: 20.h, color: AppColors.redOverlay),
          Row(
            children: [
              const Icon(
                Icons.delete_forever_rounded,
                color: AppColors.error,
                size: 20,
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Supprimer toutes les données',
                    style: GoogleFonts.roboto(
                      color: AppColors.error,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Cette action est irréversible.',
                    style: GoogleFonts.roboto(
                      color: AppColors.error.withValues(alpha: 0.7),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );

  Widget _deleteConfirmCard() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.error.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.error, width: 2.w),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: AppColors.error,
                size: 18,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Cette action est irréversible.\nToutes les tâches seront supprimées.',
                  style: GoogleFonts.roboto(
                    color: AppColors.error,
                    fontSize: 13.sp,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => setState(() => _confirm = false),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.background,
                  foregroundColor: _tx,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Annuler',
                  style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: ElevatedButton(
                onPressed: widget.onDeleteAll,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Supprimer tout',
                  style: GoogleFonts.roboto(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ─── 17. À propos ─────────────────────────────────────────────────────────────
class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  int? _open;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      // Logo + infos
      SizedBox(height: 20.h),
      Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(19.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primaryLight, _P],
                ),
                boxShadow: [
                  BoxShadow(
                    color: _P.withValues(alpha: 0.4),
                    blurRadius: 24,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.mic_rounded,
                color: AppColors.white,
                size: 40,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Smart Reminder',
              style: GoogleFonts.roboto(
                color: _tx,
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: _P.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                'Version 1.0.0',
                style: GoogleFonts.roboto(
                  color: _P,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Votre assistant personnel vocal\npour tâches et rappels.',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: _sub,
                fontSize: 14.sp,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 28.h),

      _section(
        index: 0,
        icon: Icons.description_outlined,
        color: AppColors.primary,
        title: 'À propos de l\'application',
        content: [
          _InfoParagraph(
            'Smart Reminder est votre assistant personnel vocal : parlez '
            'naturellement et l\'IA transforme vos phrases en tâches '
            'organisées, avec dates, heures et rappels.',
          ),
          _InfoParagraph(
            'La reconnaissance vocale et l\'assistant IA nécessitent une '
            'connexion internet. Si vous êtes hors ligne, vous pouvez '
            'toujours ajouter et gérer vos tâches manuellement ; vos '
            'rappels continuent de fonctionner normalement.',
          ),
          _InfoRow('Version', '1.0.0'),
          _InfoRow('Éditeur', 'Équipe to_doia'),
          _InfoRow('Technologies', 'Flutter · Dart'),
          _InfoRow('Langues', 'Français · English', last: true),
        ],
      ),
      _section(
        index: 1,
        icon: Icons.privacy_tip_outlined,
        color: AppColors.purple,
        title: 'Politique de confidentialité',
        content: [
          _InfoParagraph(
            'Vos tâches et rappels sont stockés localement sur votre '
            'appareil. Aucun compte n\'est requis et aucune donnée '
            'personnelle n\'est vendue ni partagée à des tiers.',
          ),
          _InfoBullet(
            'Microphone : utilisé uniquement pendant l\'écoute active, '
            'jamais en arrière-plan.',
          ),
          _InfoBullet('Notifications : utilisées seulement pour vos rappels.'),
          _InfoBullet(
            'Données : supprimables à tout moment depuis '
            'Réglages → Données.',
          ),
        ],
      ),
      _section(
        index: 2,
        icon: Icons.gavel_rounded,
        color: AppColors.warning,
        title: 'Conditions d\'utilisation',
        content: [
          _InfoParagraph(
            'Smart Reminder est destiné à un usage personnel. En utilisant '
            'l\'application, vous acceptez les conditions ci-dessous.',
          ),
          _InfoBullet(
            'Les rappels sont fournis à titre indicatif : vérifiez les '
            'informations importantes.',
          ),
          _InfoBullet(
            'L\'IA peut se tromper ; vous reste responsable de vos '
            'tâches et échéances.',
          ),
          _InfoBullet(
            'L\'application est fournie « en l\'état », sans garantie '
            'de disponibilité ni d\'exactitude.',
          ),
          _InfoBullet(
            'Ces conditions peuvent évoluer ; la version en vigueur est '
            'toujours celle affichée ici.',
          ),
        ],
      ),
      _section(
        index: 3,
        icon: Icons.code_rounded,
        color: AppColors.success,
        title: 'Licences open source',
        content: [
          _InfoParagraph(
            'Smart Reminder s\'appuie sur des bibliothèques open source. '
            'Merci à leurs auteurs et contributrices et contributeurs.',
          ),
          _InfoRow('Flutter · Dart', 'BSD-3-Clause'),
          _InfoRow('flutter_screenutil', 'Apache-2.0'),
          _InfoRow('google_fonts', 'Apache-2.0'),
          _InfoRow('Autres packages', 'Voir les licences'),
          SizedBox(height: 12.h),
          OutlinedButton.icon(
            onPressed: () => showLicensePage(
              context: context,
              applicationName: 'Smart Reminder',
              applicationVersion: '1.0.0',
              applicationIcon: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.mic_rounded, color: _P, size: 32),
              ),
            ),
            icon: const Icon(Icons.open_in_new_rounded, color: _P, size: 18),
            label: Text(
              'Afficher les licences complètes',
              style: GoogleFonts.roboto(
                color: _P,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: _P),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 28.h),
    ],
  );

  // ── Carte repliable : bannière + informations en dessous ──────────────────
  Widget _section({
    required int index,
    required IconData icon,
    required Color color,
    required String title,
    required List<Widget> content,
  }) {
    final isOpen = _open == index;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: isOpen ? Border.all(color: _P.withValues(alpha: 0.35)) : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _open = isOpen ? null : index),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: AppColors.white, size: 18),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.roboto(
                        color: isOpen ? _P : _tx,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isOpen ? 0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: isOpen ? _P : _sub,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isOpen)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(height: 1.h, color: AppColors.greyOverlay),
                    SizedBox(height: 12.h),
                    ...content,
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Widgets de contenu type « page d'information » ───────────────────────────
class _InfoParagraph extends StatelessWidget {
  final String text;
  const _InfoParagraph(this.text);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      text,
      style: GoogleFonts.roboto(color: _sub, fontSize: 13.sp, height: 1.65),
    ),
  );
}

class _InfoBullet extends StatelessWidget {
  final String text;
  const _InfoBullet(this.text);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 6.h, right: 8.w),
          width: 5.w,
          height: 5.w,
          decoration: const BoxDecoration(color: _P, shape: BoxShape.circle),
        ),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.roboto(
              color: _sub,
              fontSize: 13.sp,
              height: 1.6,
            ),
          ),
        ),
      ],
    ),
  );
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool last;
  const _InfoRow(this.label, this.value, {this.last = false});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      border: last
          ? null
          : const Border(bottom: BorderSide(color: AppColors.greyOverlay)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.roboto(color: _tx, fontSize: 13.sp),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.roboto(
            color: _sub,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

class _InfoTitle extends StatelessWidget {
  final String text;
  const _InfoTitle(this.text);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 8),
    child: Text(
      text.toUpperCase(),
      style: GoogleFonts.roboto(
        color: _sub,
        fontSize: 11.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
      ),
    ),
  );
}

// ─── 17 bis. Politique de confidentialité ────────────────────────────────────
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _P.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _P.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            const Icon(Icons.shield_outlined, color: _P, size: 22),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Votre vie privée compte. Voici comment Smart Reminder '
                'utilise vos données, en toute transparence.',
                style: GoogleFonts.roboto(
                  color: _tx,
                  fontSize: 13.sp,
                  height: 1.55,
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 8.h),

      _InfoTitle('Données utilisées'),
      _InfoBullet(
        'Tâches, rappels et préférences : stockés sur votre appareil.',
      ),
      _InfoBullet(
        'Voix : capturée uniquement pendant l\'écoute active, pour être '
        'transcrite en tâche.',
      ),
      _InfoBullet('Aucun compte n\'est requis et aucune donnée n\'est vendue.'),

      _InfoTitle('Microphone et connexion'),
      _InfoParagraph(
        'La reconnaissance vocale et l\'assistant IA nécessitent une '
        'connexion internet : le contenu de votre demande est transmis au '
        'service d\'IA le temps de l\'analyse, puis restitué sous forme de '
        'tâche. Hors ligne, la création manuelle reste disponible.',
      ),

      _InfoTitle('Notifications'),
      _InfoParagraph(
        'Les notifications servent uniquement à vous rappeler vos tâches. '
        'Vous pouvez les désactiver à tout moment dans Réglages → '
        'Notifications.',
      ),

      _InfoTitle('Conservation et suppression'),
      _InfoParagraph(
        'Vos données restent sur votre appareil aussi longtemps que vous le '
        'souhaitez. Vous pouvez tout supprimer depuis Réglages → Données ; '
        'cette action est définitive.',
      ),

      _InfoTitle('Partage'),
      _InfoParagraph(
        'Nous ne partageons ni ne revendons vos données personnelles à des '
        'tiers. Aucun outil de suivi publicitaire n\'est intégré. Lorsque vous '
        'envoyez un retour depuis « Envoyer un retour », le message, l\'e-mail '
        'facultatif et les informations de diagnostic (appareil, version) sont '
        'transmis à Firebase (Google) uniquement pour traiter votre demande.',
      ),

      _InfoTitle('Vos droits'),
      _InfoParagraph(
        'Vous pouvez consulter, exporter ou supprimer vos données à tout '
        'moment depuis l\'application. Pour toute question, contactez-nous '
        'via « Envoyer un retour ».',
      ),

      _InfoTitle('Mise à jour'),
      _InfoRow('Dernière mise à jour', 'Novembre 2026', last: true),
      SizedBox(height: 24.h),
    ],
  );
}

// ─── 17 ter. Envoyer un retour ───────────────────────────────────────────────
class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => FeedbackBloc(getIt<EnvoyerFeedbackUseCase>()),
    child: const _FeedbackForm(),
  );
}

class _FeedbackForm extends StatefulWidget {
  const _FeedbackForm();

  @override
  State<_FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<_FeedbackForm> {
  static const _types = [
    (TypeFeedback.bug, Icons.bug_report_outlined),
    (TypeFeedback.suggestion, Icons.lightbulb_outline_rounded),
    (TypeFeedback.autre, Icons.chat_bubble_outline_rounded),
  ];

  final _messageCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _messageCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  void _afficherMessage(String message, {required Color backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.roboto()),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<FeedbackBloc, FeedbackState>(
    listener: (context, state) {
      if (state.status == FormzSubmissionStatus.success) {
        _messageCtrl.clear();
        _emailCtrl.clear();
        _afficherMessage(
          'Merci ! Votre retour a bien été envoyé.',
          backgroundColor: AppColors.success,
        );
        context.read<FeedbackBloc>().add(FeedbackEvent.reinitialise());
      } else if (state.status == FormzSubmissionStatus.failure) {
        _afficherMessage(
          "Le retour n'a pas pu être envoyé. Réessayez.",
          backgroundColor: AppColors.error,
        );
      }
    },
    builder: (context, state) => ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _InfoTitle('Type de retour'),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            for (var i = 0; i < _types.length; i++)
              GestureDetector(
                onTap: () => context.read<FeedbackBloc>().add(
                  FeedbackEvent.typeChanged(_types[i].$1),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: state.type == _types[i].$1 ? _P : AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: state.type == _types[i].$1
                          ? _P
                          : AppColors.greyOverlay,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _types[i].$2,
                        size: 16,
                        color: state.type == _types[i].$1
                            ? AppColors.white
                            : _P,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        _types[i].$1.libelle,
                        style: GoogleFonts.roboto(
                          color: state.type == _types[i].$1
                              ? AppColors.white
                              : _tx,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 16.h),

        _InfoTitle('Votre message'),
        _field(
          controller: _messageCtrl,
          hint: 'Décrivez ce qui s\'est passé ou ce que vous aimeriez voir...',
          maxLines: 6,
          onChanged: (value) => context.read<FeedbackBloc>().add(
            FeedbackEvent.messageChanged(value),
          ),
        ),
        SizedBox(height: 16.h),

        _InfoTitle('E-mail (facultatif)'),
        _field(
          controller: _emailCtrl,
          hint: 'vous@exemple.com',
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => context.read<FeedbackBloc>().add(
            FeedbackEvent.emailChanged(value),
          ),
        ),
        if (state.email.displayError != null) ...[
          SizedBox(height: 6.h),
          Text(
            'Adresse e-mail invalide.',
            style: GoogleFonts.roboto(color: AppColors.error, fontSize: 11.sp),
          ),
        ],
        SizedBox(height: 20.h),

        ElevatedButton.icon(
          onPressed: state.status.isInProgress || !state.isValide
              ? null
              : () {
                  FocusScope.of(context).unfocus();
                  context.read<FeedbackBloc>().add(FeedbackEvent.submitted());
                },
          icon: state.status.isInProgress
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.white,
                  ),
                )
              : const Icon(Icons.send_rounded, size: 18),
          label: Text(
            state.status.isInProgress
                ? 'Envoi en cours...'
                : 'Envoyer le retour',
            style: GoogleFonts.roboto(fontWeight: FontWeight.w700),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: _P,
            foregroundColor: AppColors.white,
            disabledBackgroundColor: _P.withValues(alpha: 0.6),
            disabledForegroundColor: AppColors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'Votre appareil et la version de l\'application sont joints '
          'automatiquement pour faciliter le diagnostic.',
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(color: _sub, fontSize: 11.sp, height: 1.5),
        ),
        SizedBox(height: 24.h),
      ],
    ),
  );

  Widget _field({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    ValueChanged<String>? onChanged,
  }) => Container(
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: AppColors.greyOverlay),
    ),
    child: TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: GoogleFonts.roboto(color: _tx, fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.roboto(color: _sub, fontSize: 13.sp),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(14),
      ),
    ),
  );
}

// ─── 18. Aide ─────────────────────────────────────────────────────────────────
class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});
  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  int? _open;

  static const _faq = [
    (
      'Comment créer une tâche ?',
      'Appuyez sur le bouton microphone depuis l\'accueil. Parlez naturellement : "Demain à 10h, rappelle-moi d\'appeler Jean." L\'IA crée la tâche automatiquement.',
    ),
    (
      'Comment modifier une tâche ?',
      'Dans Mes Tâches, appuyez sur ··· à droite de la tâche puis sélectionnez Modifier.',
    ),
    (
      'Comment supprimer une tâche ?',
      'Appuyez sur ··· puis Supprimer. Une confirmation vous sera demandée si l\'option est activée.',
    ),
    (
      'Comment utiliser la commande vocale ?',
      'Parlez naturellement. L\'IA comprend les dates relatives ("demain", "dans 3 jours") et les récurrences ("tous les lundis").',
    ),
    (
      'Pourquoi l\'app n\'a pas compris ?',
      'Parlez clairement en précisant la tâche, la date et l\'heure. Évitez le bruit ambiant. Sinon créez la tâche manuellement.',
    ),
    (
      'Comment fonctionnent les rappels ?',
      'Ce sont des notifications locales, affichées à l\'heure programmée même si l\'app est fermée. Assurez-vous que les notifications sont autorisées.',
    ),
  ];

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      Text(
        'QUESTIONS FRÉQUENTES',
        style: GoogleFonts.roboto(
          color: _sub,
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
      SizedBox(height: 12.h),

      ..._faq.asMap().entries.map((e) {
        final isOpen = _open == e.key;
        return GestureDetector(
          onTap: () => setState(() => _open = isOpen ? null : e.key),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: isOpen
                  ? Border.all(color: _P.withValues(alpha: 0.35))
                  : null,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          e.value.$1,
                          style: GoogleFonts.roboto(
                            color: _tx,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      AnimatedRotation(
                        turns: isOpen ? 0.25 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: const Icon(
                          Icons.chevron_right_rounded,
                          color: _P,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isOpen)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      e.value.$2,
                      style: GoogleFonts.roboto(
                        color: _sub,
                        fontSize: 13.sp,
                        height: 1.65,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
      SizedBox(height: 16.h),

      // Support
      GestureDetector(
        onTap: () => SharaNav.navigate('feedback'),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _P,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Text('🎧', style: GoogleFonts.roboto(fontSize: 24.sp)),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contacter le support',
                      style: GoogleFonts.roboto(
                        color: AppColors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Réponse en moins de 24h',
                      style: GoogleFonts.roboto(
                        color: Colors.white70,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 32.h),
    ],
  );
}
