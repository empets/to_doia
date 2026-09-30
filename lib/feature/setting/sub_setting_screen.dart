// lib/screens/settings_sub_screens.dart
import 'package:flutter/material.dart';
import 'package:to_doia/core/models/task.dart';

const _P = Color(0xFF6366F1);
const _sub = Color(0xFF6B7280);
const _tx = Color(0xFF1A1A2E);

// ── Réutilisable ──────────────────────────────────────────────────────────────
class SubScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  const SubScaffold({super.key, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF4F6FB),
    appBar: AppBar(
      backgroundColor: const Color(0xFFF4F6FB),
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _P.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.chevron_left_rounded, color: _P))),
      title: Text(title,
        style: const TextStyle(
          color: _tx, fontSize: 17, fontWeight: FontWeight.w700)),
    ),
    body: body,
  );
}

// ─── 12. Apparence ────────────────────────────────────────────────────────────
class AppearanceScreen extends StatefulWidget {
  final String initialTheme;
  final void Function(String) onChanged;
  const AppearanceScreen({super.key,
    required this.initialTheme, required this.onChanged});
  @override
  State<AppearanceScreen> createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends State<AppearanceScreen> {
  late String _theme;
  @override
  void initState() { super.initState(); _theme = widget.initialTheme; }

  @override
  Widget build(BuildContext context) => SubScaffold(
    title: 'Apparence',
    body: ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Choisissez un thème',
        style: TextStyle(color: _sub, fontSize: 13)),
      const SizedBox(height: 14),

      // Cartes de thème
      Row(children: [
        for (final t in [
          ('system', '🔄', 'Système'),
          ('light',  '☀️', 'Clair'),
          ('dark',   '🌙', 'Sombre'),
        ]) ...[
          Expanded(child: GestureDetector(
            onTap: () { setState(() => _theme = t.$1); widget.onChanged(t.$1); },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _theme == t.$1 ? _P : Colors.transparent,
                  width: 2),
                boxShadow: [BoxShadow(
                  color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
              child: Column(children: [
                Text(t.$2, style: const TextStyle(fontSize: 28)),
                const SizedBox(height: 8),
                Text(t.$3,
                  style: TextStyle(
                    color: _theme == t.$1 ? _P : _sub,
                    fontSize: 13, fontWeight: FontWeight.w600)),
                if (_theme == t.$1) ...[
                  const SizedBox(height: 4),
                  const Icon(Icons.check_rounded, color: _P, size: 16),
                ],
              ]),
            ),
          )),
          if (t.$1 != 'dark') const SizedBox(width: 10),
        ],
      ]),
      const SizedBox(height: 24),

      const Text('Aperçu', style: TextStyle(color: _sub, fontSize: 13)),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _P.withOpacity(0.2))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Smart Reminder',
            style: TextStyle(color: _P, fontSize: 15, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          const Text('Bonjour 👋', style: TextStyle(color: _tx, fontSize: 14)),
          const SizedBox(height: 8),
          Container(height: 8, width: 110,
            decoration: BoxDecoration(
              color: _P.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4))),
        ])),
    ]),
  );
}

// ─── 13. Langue ───────────────────────────────────────────────────────────────
class LanguageScreen extends StatefulWidget {
  final String appLang, voiceLang;
  final void Function(String) onAppLang, onVoiceLang;
  const LanguageScreen({super.key,
    required this.appLang, required this.voiceLang,
    required this.onAppLang, required this.onVoiceLang});
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
    body: ListView(padding: const EdgeInsets.all(20), children: [
      _choiceGroup(
        title: "Langue de l'application",
        opts: [('Français', '🇫🇷'), ('English', '🇬🇧')],
        value: _app,
        onSelect: (v) { setState(() => _app = v); widget.onAppLang(v); }),
      const SizedBox(height: 24),
      _choiceGroup(
        title: 'Langue de reconnaissance vocale',
        opts: [('Français', '🇫🇷'), ('English', '🇬🇧'), ('Détection automatique', '🌐')],
        value: _voice,
        onSelect: (v) { setState(() => _voice = v); widget.onVoiceLang(v); }),
    ]),
  );

  Widget _choiceGroup({
    required String title,
    required List<(String, String)> opts,
    required String value,
    required void Function(String) onSelect,
  }) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title.toUpperCase(),
      style: const TextStyle(
        color: _sub, fontSize: 11,
        fontWeight: FontWeight.w700, letterSpacing: 0.8)),
    const SizedBox(height: 10),
    Container(
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
      child: Column(children: opts.asMap().entries.map((e) {
        final (label, flag) = e.value;
        return Column(children: [
          ListTile(
            onTap: () => onSelect(label),
            leading: Text(flag, style: const TextStyle(fontSize: 22)),
            title: Text(label,
              style: const TextStyle(
                color: _tx, fontSize: 15, fontWeight: FontWeight.w500)),
            trailing: value == label
              ? const Icon(Icons.check_rounded, color: _P, size: 20)
              : null),
          if (e.key < opts.length - 1)
            const Divider(height: 1, indent: 56, color: Color(0x1A6B7280)),
        ]);
      }).toList()),
    ),
  ]);
}

// ─── 14. Notifications ────────────────────────────────────────────────────────
class NotificationsSettingsScreen extends StatefulWidget {
  final bool notifOn, soundOn, vibOn;
  final void Function(bool) onNotif, onSound, onVib;
  final String lateReminder, reminderBefore;
  final void Function(String) onLate, onBefore;

  const NotificationsSettingsScreen({super.key,
    required this.notifOn, required this.soundOn, required this.vibOn,
    required this.onNotif, required this.onSound, required this.onVib,
    required this.lateReminder, required this.reminderBefore,
    required this.onLate, required this.onBefore});
  @override
  State<NotificationsSettingsScreen> createState() => _NotifSettingsState();
}

class _NotifSettingsState extends State<NotificationsSettingsScreen> {
  late bool _notif, _sound, _vib;
  late String _late, _before;

  @override
  void initState() {
    super.initState();
    _notif = widget.notifOn; _sound = widget.soundOn; _vib = widget.vibOn;
    _late = widget.lateReminder; _before = widget.reminderBefore;
  }

  @override
  Widget build(BuildContext context) => SubScaffold(
    title: 'Notifications',
    body: ListView(padding: const EdgeInsets.symmetric(horizontal: 20), children: [
      _group('Général', [
        _row(Icons.notifications_rounded, const Color(0xFFEF4444), 'Autoriser',
          Switch(value: _notif, onChanged: (v) { setState(() => _notif = v); widget.onNotif(v); },
            activeColor: _P, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
        _row(Icons.volume_up_rounded, const Color(0xFF8B5CF6), 'Son',
          Switch(value: _sound, onChanged: (v) { setState(() => _sound = v); widget.onSound(v); },
            activeColor: _P, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
        _row(Icons.vibration_rounded, const Color(0xFF06B6D4), 'Vibration',
          Switch(value: _vib, onChanged: (v) { setState(() => _vib = v); widget.onVib(v); },
            activeColor: _P, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
          last: true),
      ]),
      _choiceSection('Rappels en retard',
        ['Ignorer', 'Notifier immédiatement', 'Reporter'],
        _late, (v) { setState(() => _late = v); widget.onLate(v); }),
      _choiceSection('Rappel avant',
        ['Aucun', '5 minutes', '10 minutes', '15 minutes', '30 minutes'],
        _before, (v) { setState(() => _before = v); widget.onBefore(v); }),
      const SizedBox(height: 32),
    ]),
  );

  Widget _group(String title, List<Widget> children) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(padding: const EdgeInsets.fromLTRB(2, 20, 2, 8),
        child: Text(title.toUpperCase(),
          style: const TextStyle(color: _sub, fontSize: 11,
            fontWeight: FontWeight.w700, letterSpacing: 0.8))),
      Container(
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
        child: Column(children: children)),
    ],
  );

  Widget _row(IconData icon, Color bg, String label, Widget trailing, {bool last = false}) =>
    Container(
      decoration: BoxDecoration(
        border: last ? null : const Border(bottom: BorderSide(color: Color(0x1A6B7280)))),
      child: ListTile(
        leading: Container(width: 36, height: 36,
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: Colors.white, size: 18)),
        title: Text(label, style: const TextStyle(color: _tx, fontSize: 15, fontWeight: FontWeight.w500)),
        trailing: trailing));

  Widget _choiceSection(String title, List<String> opts, String value, void Function(String) onSelect) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.fromLTRB(2, 20, 2, 8),
        child: Text(title.toUpperCase(),
          style: const TextStyle(color: _sub, fontSize: 11,
            fontWeight: FontWeight.w700, letterSpacing: 0.8))),
      Container(
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
        child: Column(children: opts.asMap().entries.map((e) => Column(children: [
          ListTile(
            onTap: () => onSelect(e.value),
            title: Text(e.value, style: const TextStyle(color: _tx, fontSize: 15)),
            trailing: value == e.value
              ? const Icon(Icons.check_rounded, color: _P, size: 20)
              : null),
          if (e.key < opts.length - 1)
            const Divider(height: 1, indent: 16, color: Color(0x1A6B7280)),
        ])).toList()),
      ),
    ]);
}

// ─── 15. Voix & IA ────────────────────────────────────────────────────────────
class VoiceAIScreen extends StatefulWidget {
  final bool confirmCreate;
  final void Function(bool) onConfirmCreate;
  const VoiceAIScreen({super.key,
    required this.confirmCreate, required this.onConfirmCreate});
  @override
  State<VoiceAIScreen> createState() => _VoiceAIScreenState();
}

class _VoiceAIScreenState extends State<VoiceAIScreen> {
  late bool _confirm;
  @override
  void initState() { super.initState(); _confirm = widget.confirmCreate; }

  @override
  Widget build(BuildContext context) => SubScaffold(
    title: 'Voix et IA',
    body: ListView(padding: const EdgeInsets.all(20), children: [
      _group('Reconnaissance vocale', [
        _tile(Icons.language_rounded, const Color(0xFF10B981), 'Langue', sub: 'Français'),
        _tile(Icons.auto_fix_high_rounded, const Color(0xFF6366F1),
          'Fin de phrase automatique',
          trail: Switch(value: true, onChanged: (_) {},
            activeColor: _P, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
        _tile(Icons.subtitles_rounded, const Color(0xFF8B5CF6),
          'Afficher la transcription', last: true,
          trail: Switch(value: true, onChanged: (_) {},
            activeColor: _P, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
      ]),
      _group('Assistant IA', [
        _tile(Icons.check_circle_rounded, const Color(0xFF10B981),
          'Confirmer avant création',
          trail: Switch(
            value: _confirm,
            onChanged: (v) { setState(() => _confirm = v); widget.onConfirmCreate(v); },
            activeColor: _P, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
        _tile(Icons.calendar_today_rounded, const Color(0xFFF59E0B),
          'Dates relatives', sub: '"Demain", "Dans 2 jours"...',
          trail: Switch(value: true, onChanged: (_) {},
            activeColor: _P, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
        _tile(Icons.repeat_rounded, const Color(0xFF06B6D4),
          'Tâches récurrentes', sub: '"Tous les lundis"...', last: true,
          trail: Switch(value: true, onChanged: (_) {},
            activeColor: _P, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
      ]),

      // Exemple
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _P.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _P.withOpacity(0.2))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Row(children: [
            Icon(Icons.lightbulb_outline_rounded, color: _P, size: 16),
            SizedBox(width: 8),
            Text('Exemple', style: TextStyle(color: _P, fontSize: 13, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 10),
          const Text(
            '"Tous les lundis à 8h, rappelle-moi de faire mon rapport."',
            style: TextStyle(color: _tx, fontSize: 13, fontStyle: FontStyle.italic, height: 1.5)),
          const SizedBox(height: 12),
          for (final row in [['📝', 'Faire mon rapport'], ['🔁', 'Chaque lundi'], ['🕐', '08:00']])
            Padding(padding: const EdgeInsets.only(bottom: 6),
              child: Row(children: [
                Text(row[0], style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                Text(row[1], style: const TextStyle(color: _tx, fontSize: 13, fontWeight: FontWeight.w500)),
              ])),
        ])),
      const SizedBox(height: 16),

      OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.mic_rounded, color: _P, size: 18),
        label: const Text('Tester le microphone',
          style: TextStyle(color: _P, fontWeight: FontWeight.w600)),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: _P),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))),
    ]),
  );

  Widget _group(String title, List<Widget> children) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(padding: const EdgeInsets.fromLTRB(2, 20, 2, 8),
        child: Text(title.toUpperCase(),
          style: const TextStyle(color: _sub, fontSize: 11,
            fontWeight: FontWeight.w700, letterSpacing: 0.8))),
      Container(
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
        child: Column(children: children)),
    ],
  );

  Widget _tile(IconData icon, Color bg, String label,
      {String? sub, Widget? trail, bool last = false}) =>
    Container(
      decoration: BoxDecoration(
        border: last ? null : const Border(bottom: BorderSide(color: Color(0x1A6B7280)))),
      child: ListTile(
        leading: Container(width: 36, height: 36,
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: Colors.white, size: 18)),
        title: Text(label, style: const TextStyle(color: _tx, fontSize: 15, fontWeight: FontWeight.w500)),
        subtitle: sub != null ? Text(sub, style: const TextStyle(color: _sub, fontSize: 12)) : null,
        trailing: trail ?? const Icon(Icons.chevron_right_rounded, color: _sub, size: 20)));
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
      body: ListView(padding: const EdgeInsets.all(20), children: [
        // Stats
        Row(children: [
          _statCard('${widget.tasks.length}', 'Tâches totales', const Color(0xFF6366F1)),
          const SizedBox(width: 12),
          _statCard('$done', 'Terminées', const Color(0xFF10B981)),
        ]),
        const SizedBox(height: 24),

        // Actions
        _group([
          _tile(Icons.history_rounded, const Color(0xFF8B5CF6), 'Historique', 'Tâches supprimées'),
          _tile(Icons.upload_rounded, const Color(0xFF10B981), 'Exporter', 'Format JSON'),
          _tile(Icons.download_rounded, const Color(0xFF06B6D4), 'Importer', 'Restaurer', last: true),
        ]),
        const SizedBox(height: 20),

        // Zone danger
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: _confirm ? _deleteConfirmCard() : _dangerCard(),
        ),
      ]),
    );
  }

  Widget _statCard(String value, String label, Color color) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
      child: Column(children: [
        Text(value, style: TextStyle(color: color, fontSize: 28, fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: _sub, fontSize: 12)),
      ])),
  );

  Widget _group(List<Widget> children) => Container(
    decoration: BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(16),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
    child: Column(children: children));

  Widget _tile(IconData icon, Color bg, String label, String sub, {bool last = false}) =>
    Container(
      decoration: BoxDecoration(
        border: last ? null : const Border(bottom: BorderSide(color: Color(0x1A6B7280)))),
      child: ListTile(
        leading: Container(width: 36, height: 36,
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: Colors.white, size: 18)),
        title: Text(label, style: const TextStyle(color: _tx, fontSize: 15, fontWeight: FontWeight.w500)),
        subtitle: Text(sub, style: const TextStyle(color: _sub, fontSize: 12)),
        trailing: const Icon(Icons.chevron_right_rounded, color: _sub, size: 20)));

  Widget _dangerCard() => GestureDetector(
    onTap: () => setState(() => _confirm = true),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEF4444).withOpacity(0.3))),
      child: Column(children: [
        const Row(children: [
          Icon(Icons.warning_amber_rounded, color: Color(0xFFEF4444), size: 20),
          SizedBox(width: 10),
          Text('Zone de danger',
            style: TextStyle(color: Color(0xFFEF4444), fontSize: 14, fontWeight: FontWeight.w700)),
        ]),
        const Divider(height: 20, color: Color(0x1AEF4444)),
        Row(children: [
          const Icon(Icons.delete_forever_rounded, color: Color(0xFFEF4444), size: 20),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Supprimer toutes les données',
              style: TextStyle(color: Color(0xFFEF4444),
                fontSize: 14, fontWeight: FontWeight.w600)),
            Text('Cette action est irréversible.',
              style: TextStyle(color: const Color(0xFFEF4444).withOpacity(0.7), fontSize: 12)),
          ]),
        ]),
      ]),
    ),
  );

  Widget _deleteConfirmCard() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFEF4444).withOpacity(0.06),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFEF4444), width: 2)),
    child: Column(children: [
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444).withOpacity(0.12),
          borderRadius: BorderRadius.circular(10)),
        child: const Row(children: [
          Icon(Icons.warning_amber_rounded, color: Color(0xFFEF4444), size: 18),
          SizedBox(width: 8),
          Expanded(child: Text('Cette action est irréversible.\nToutes les tâches seront supprimées.',
            style: TextStyle(color: Color(0xFFEF4444), fontSize: 13, height: 1.4))),
        ])),
      const SizedBox(height: 16),
      Row(children: [
        Expanded(child: TextButton(
          onPressed: () => setState(() => _confirm = false),
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFFF4F6FB),
            foregroundColor: _tx,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          child: const Text('Annuler', style: TextStyle(fontWeight: FontWeight.w600)))),
        const SizedBox(width: 10),
        Expanded(child: ElevatedButton(
          onPressed: widget.onDeleteAll,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEF4444),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0),
          child: const Text('Supprimer tout', style: TextStyle(fontWeight: FontWeight.w700)))),
      ]),
    ]));
}

// ─── 17. À propos ─────────────────────────────────────────────────────────────
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) => SubScaffold(
    title: 'À propos',
    body: ListView(padding: const EdgeInsets.all(20), children: [
      // Logo + infos
      Center(child: Column(children: [
        Container(
          width: 88, height: 88,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: const LinearGradient(
              begin: Alignment.topLeft, end: Alignment.bottomRight,
              colors: [Color(0xFF818CF8), _P]),
            boxShadow: [BoxShadow(
              color: _P.withOpacity(0.4), blurRadius: 24, spreadRadius: 2)]),
          child: const Icon(Icons.mic_rounded, color: Colors.white, size: 40)),
        const SizedBox(height: 16),
        const Text('Smart Reminder',
          style: TextStyle(color: _tx, fontSize: 24, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: _P.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
          child: const Text('Version 1.0.0',
            style: TextStyle(color: _P, fontSize: 12, fontWeight: FontWeight.w700))),
        const SizedBox(height: 10),
        const Text(
          'Votre assistant personnel vocal\npour tâches et rappels.',
          textAlign: TextAlign.center,
          style: TextStyle(color: _sub, fontSize: 14, height: 1.6)),
      ])),
      const SizedBox(height: 28),

      _group([
        _tile(Icons.description_outlined, const Color(0xFF6366F1), 'À propos de l\'application'),
        _tile(Icons.privacy_tip_outlined, const Color(0xFF8B5CF6), 'Politique de confidentialité'),
        _tile(Icons.gavel_rounded, const Color(0xFFF59E0B), "Conditions d'utilisation"),
        _tile(Icons.code_rounded, const Color(0xFF10B981), 'Licences open source', last: true),
      ]),
      const SizedBox(height: 28),

      const Center(child: Text('Développé avec Flutter ❤️',
        style: TextStyle(color: _sub, fontSize: 13))),
    ]),
  );

  static Widget _group(List<Widget> children) => Container(
    decoration: BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(16),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
    child: Column(children: children));

  static Widget _tile(IconData icon, Color bg, String label, {bool last = false}) =>
    Container(
      decoration: BoxDecoration(
        border: last ? null : const Border(bottom: BorderSide(color: Color(0x1A6B7280)))),
      child: ListTile(
        leading: Container(width: 36, height: 36,
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: Colors.white, size: 18)),
        title: Text(label, style: const TextStyle(color: _tx, fontSize: 15, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right_rounded, color: _sub, size: 20)));
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
    ('Comment créer une tâche ?',
      'Appuyez sur le bouton microphone depuis l\'accueil. Parlez naturellement : "Demain à 10h, rappelle-moi d\'appeler Jean." L\'IA crée la tâche automatiquement.'),
    ('Comment modifier une tâche ?',
      'Dans Mes Tâches, appuyez sur ··· à droite de la tâche puis sélectionnez Modifier.'),
    ('Comment supprimer une tâche ?',
      'Appuyez sur ··· puis Supprimer. Une confirmation vous sera demandée si l\'option est activée.'),
    ('Comment utiliser la commande vocale ?',
      'Parlez naturellement. L\'IA comprend les dates relatives ("demain", "dans 3 jours") et les récurrences ("tous les lundis").'),
    ('Pourquoi l\'app n\'a pas compris ?',
      'Parlez clairement en précisant la tâche, la date et l\'heure. Évitez le bruit ambiant. Sinon créez la tâche manuellement.'),
    ('Comment fonctionnent les rappels ?',
      'Ce sont des notifications locales, affichées à l\'heure programmée même si l\'app est fermée. Assurez-vous que les notifications sont autorisées.'),
  ];

  @override
  Widget build(BuildContext context) => SubScaffold(
    title: 'Aide',
    body: ListView(padding: const EdgeInsets.all(20), children: [
      const Text('QUESTIONS FRÉQUENTES',
        style: TextStyle(color: _sub, fontSize: 11,
          fontWeight: FontWeight.w700, letterSpacing: 0.8)),
      const SizedBox(height: 12),

      ..._faq.asMap().entries.map((e) {
        final isOpen = _open == e.key;
        return GestureDetector(
          onTap: () => setState(() => _open = isOpen ? null : e.key),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: isOpen ? Border.all(color: _P.withOpacity(0.35)) : null,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(children: [
                  Expanded(child: Text(e.value.$1,
                    style: const TextStyle(color: _tx, fontSize: 14, fontWeight: FontWeight.w600))),
                  AnimatedRotation(
                    turns: isOpen ? 0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.chevron_right_rounded, color: _P, size: 20)),
                ])),
              if (isOpen) Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(e.value.$2,
                  style: const TextStyle(
                    color: _sub, fontSize: 13, height: 1.65))),
            ]),
          ),
        );
      }),
      const SizedBox(height: 16),

      // Support
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _P, borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          const Text('🎧', style: TextStyle(fontSize: 24)),
          const SizedBox(width: 14),
          const Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Contacter le support',
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
              Text('Réponse en moins de 24h',
                style: TextStyle(color: Colors.white70, fontSize: 12)),
            ])),
          const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
        ]),
      ),
      const SizedBox(height: 32),
    ]),
  );
}
