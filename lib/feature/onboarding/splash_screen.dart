import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onFinish;
  const SplashScreen({super.key, required this.onFinish});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this, duration: const Duration(milliseconds: 900));
  late final Animation<double> _scale =
      CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
  late final Animation<double> _fade =
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.4, 1, curve: Curves.easeOut));

  @override
  void initState() {
    super.initState();
    _ctrl.forward();
    Future.delayed(const Duration(milliseconds: 2600), widget.onFinish);
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF0F0F1E),
    body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Logo
        ScaleTransition(
          scale: _scale,
          child: Container(
            width: 100, height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                colors: [Color(0xFF818CF8), Color(0xFF6366F1)]),
              boxShadow: [BoxShadow(
                color: const Color(0xFF6366F1).withOpacity(0.45),
                blurRadius: 40, spreadRadius: 4)],
            ),
            child: const Icon(Icons.mic_rounded, color: Colors.white, size: 48),
          ),
        ),
        const SizedBox(height: 32),

        // Titre + sous-titre
        FadeTransition(
          opacity: _fade,
          child: Column(children: [
            const Text('Smart Reminder',
              style: TextStyle(
                color: Colors.white, fontSize: 32,
                fontWeight: FontWeight.w800, letterSpacing: -1)),
            const SizedBox(height: 10),
            Text(
              'Votre assistant vocal pour\ntâches et rappels.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 15, height: 1.6)),
          ]),
        ),
        const SizedBox(height: 72),

        // Dots
        FadeTransition(
          opacity: _fade,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (i) => Container(
              width: i == 1 ? 24 : 8, height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: i == 1
                  ? const Color(0xFF6366F1)
                  : Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4)),
            )),
          ),
        ),
      ]),
    ),
  );
}