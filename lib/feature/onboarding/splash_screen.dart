import 'package:flutter/material.dart';

/// Écran de lancement — sobre et fluide :
/// - fondu enchaîné global
/// - léger zoom du logo
/// - fine barre de progression discrète
class SplashScreen extends StatefulWidget {
  final VoidCallback onFinish;
  const SplashScreen({super.key, required this.onFinish});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const _indigo = Color(0xFF6366F1);

  // Un seul controller : tout est décalé dans le temps avec des Interval
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  );

  // Logo : zoom doux de 0.9 → 1.0 dans les 600 premières ms
  late final Animation<double> _logoScale = Tween(begin: 0.9, end: 1.0)
      .animate(
        CurvedAnimation(
          parent: _ctrl,
          curve: const Interval(0, 0.3, curve: Curves.easeOutCubic),
        ),
      );

  // Logo : opacité 0 → 1 sur les 500 premières ms
  late final Animation<double> _logoFade = Tween(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0, 0.25, curve: Curves.easeOut),
    ),
  );

  // Textes : apparaissent en fondu juste après (250 → 750 ms)
  late final Animation<double> _textFade = Tween(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.15, 0.45, curve: Curves.easeOut),
    ),
  );

  // Loader : barre de progression sur toute la durée
  late final Animation<double> _progress = Tween(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.1, 1, curve: Curves.easeInOut),
    ),
  );

  @override
  void initState() {
    super.initState();
    _ctrl.forward();
    Future.delayed(const Duration(milliseconds: 2600), widget.onFinish);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ---- Logo : fondu + zoom léger ----
            FadeTransition(
              opacity: _logoFade,
              child: ScaleTransition(
                scale: _logoScale,
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF818CF8), Color(0xFF6366F1)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _indigo.withValues(alpha: 0.4),
                        blurRadius: 40,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.mic_rounded,
                    color: Colors.white,
                    size: 46,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // ---- Titre + sous-titre : fondu simple ----
            FadeTransition(
              opacity: _textFade,
              child: Column(
                children: [
                  const Text(
                    'Smart Reminder',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Votre assistant vocal pour\ntâches et rappels.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.45),
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 64),

            // ---- Barre de progression fine et discrète ----
            FadeTransition(
              opacity: _textFade,
              child: SizedBox(
                width: 140,
                height: 3,
                child: AnimatedBuilder(
                  animation: _progress,
                  builder: (context, _) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: _progress.value,
                            child: Container(
                              height: 3,
                              decoration: BoxDecoration(
                                color: const Color(0xFF818CF8),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
