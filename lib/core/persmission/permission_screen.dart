// lib/screens/permissions_screen.dart
import 'package:flutter/material.dart';

class PermissionsScreen extends StatefulWidget {
  final VoidCallback onDone;
  const PermissionsScreen({super.key, required this.onDone});
  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  int _step = 0; // 0 = micro, 1 = notifications
  bool _micGranted  = false;
  bool _notifGranted = false;

  static const _primary = Color(0xFF6366F1);

  final _steps = [
    {
      'icon': Icons.mic_rounded,
      'color': Color(0xFF6366F1),
      'title': 'Autoriser le microphone',
      'desc': 'Le microphone est utilisé pour transformer votre voix en tâches. '
              'Aucun enregistrement n\'est conservé.',
      'btn': 'Autoriser le microphone',
      'skip': 'Continuer sans microphone',
    },
    {
      'icon': Icons.notifications_rounded,
      'color': Color(0xFF10B981),
      'title': 'Activer les notifications',
      'desc': 'Autorisez les notifications pour recevoir vos rappels au bon moment, '
              'même lorsque l\'application est fermée.',
      'btn': 'Activer les notifications',
      'skip': 'Continuer sans notifications',
    },
  ];

  void _grant() {
    setState(() {
      if (_step == 0) _micGranted  = true;
      else            _notifGranted = true;
    });
    _next();
  }

  void _next() {
    if (_step < _steps.length - 1) {
      setState(() => _step++);
    } else {
      widget.onDone();
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _steps[_step];
    final color = s['color'] as Color;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(children: [
            // Progression
            Row(children: List.generate(_steps.length, (i) => Expanded(
              child: Container(
                height: 4, margin: EdgeInsets.only(right: i < _steps.length - 1 ? 6 : 0),
                decoration: BoxDecoration(
                  color: i <= _step ? _primary : const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(2)),
              ),
            ))),
            const SizedBox(height: 56),

            // Icône animée
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Container(
                key: ValueKey(_step),
                width: 120, height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.1),
                ),
                child: Icon(s['icon'] as IconData, color: color, size: 56),
              ),
            ),
            const SizedBox(height: 36),

            Text(s['title'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF1A1A2E), fontSize: 26,
                fontWeight: FontWeight.w800, height: 1.2)),
            const SizedBox(height: 14),
            Text(s['desc'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF6B7280), fontSize: 15, height: 1.65)),

            const Spacer(),

            // Bouton principal
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _grant,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary, foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  elevation: 0),
                child: Text(s['btn'] as String,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: 12),

            // Bouton secondaire
            TextButton(
              onPressed: _next,
              child: Text(s['skip'] as String,
                style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14)),
            ),

            // Lien si permission refusée
            if (_step == 0)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.settings_rounded,
                    size: 15, color: Color(0xFF6366F1)),
                  label: const Text('Ouvrir les paramètres système',
                    style: TextStyle(color: Color(0xFF6366F1), fontSize: 13)),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}
