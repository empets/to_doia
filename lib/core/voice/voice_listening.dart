// lib/screens/voice_listening_screen.dart
import 'dart:math';
import 'package:flutter/material.dart';

class VoiceListeningScreen extends StatefulWidget {
  final VoidCallback onStop;
  final VoidCallback onCancel;
  const VoiceListeningScreen({super.key,
    required this.onStop, required this.onCancel});
  @override
  State<VoiceListeningScreen> createState() => _VoiceListeningScreenState();
}

class _VoiceListeningScreenState extends State<VoiceListeningScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this, duration: const Duration(milliseconds: 1200))..repeat(reverse: true);
  late final AnimationController _wave = AnimationController(
    vsync: this, duration: const Duration(milliseconds: 80))..repeat(reverse: true);

  final List<double> _waveHeights = List.generate(9, (_) => 8);
  int _tick = 0;

  @override
  void initState() {
    super.initState();
    _wave.addListener(_updateWave);
  }

  void _updateWave() {
    setState(() {
      _tick++;
      for (int i = 0; i < _waveHeights.length; i++) {
        _waveHeights[i] = 8 + (sin((_tick * 0.3 + i) * 0.9).abs() * 22);
      }
    });
  }

  @override
  void dispose() {
    _pulse.dispose();
    _wave.removeListener(_updateWave);
    _wave.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Statut
          const Text('Je vous écoute...',
            style: TextStyle(
              color: Color(0xFF6B7280), fontSize: 16,
              fontWeight: FontWeight.w500)),
          const SizedBox(height: 48),

          // Microphone animé
          AnimatedBuilder(
            animation: _pulse,
            builder: (_, __) => SizedBox(
              width: 200, height: 200,
              child: Stack(alignment: Alignment.center, children: [
                ...List.generate(3, (i) => Container(
                  width: 100 + (i+1)*30 + _pulse.value*10,
                  height: 100 + (i+1)*30 + _pulse.value*10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF6366F1)
                      .withOpacity(0.1 - i * 0.025)),
                )),
                Container(
                  width: 100, height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF818CF8), Color(0xFF6366F1)]),
                    boxShadow: [BoxShadow(
                      color: const Color(0xFF6366F1)
                        .withOpacity(0.5 + _pulse.value * 0.1),
                      blurRadius: 36 + _pulse.value * 10)]),
                  child: const Icon(Icons.mic_rounded, color: Colors.white, size: 44),
                ),
              ]),
            ),
          ),
          const SizedBox(height: 40),

          // Ondes audio
          SizedBox(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _waveHeights.asMap().entries.map((e) => AnimatedContainer(
                duration: const Duration(milliseconds: 80),
                width: 5, height: e.value,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: Color.lerp(
                    const Color(0xFF818CF8),
                    const Color(0xFF6366F1),
                    e.value / 30),
                  borderRadius: BorderRadius.circular(4)),
              )).toList(),
            ),
          ),
          const SizedBox(height: 40),

          // Indication enregistrement
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: 8, height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFEF4444), shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            const Text('Enregistrement en cours...',
              style: TextStyle(color: Color(0xFF6B7280), fontSize: 14)),
          ]),
          const SizedBox(height: 48),

          // Bouton Arrêter
          GestureDetector(
            onTap: widget.onStop,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF6366F1), width: 2),
                borderRadius: BorderRadius.circular(32)),
              child: const Text('Arrêter',
                style: TextStyle(
                  color: Color(0xFF6366F1), fontSize: 15,
                  fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 14),

          TextButton(
            onPressed: widget.onCancel,
            child: const Text('Annuler',
              style: TextStyle(color: Color(0xFF6B7280), fontSize: 14))),
        ],
      ),
    ),
  );
}