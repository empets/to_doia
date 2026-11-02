import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/constante/app_colors.dart';

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
  static const _indigo = AppColors.primary;

  // Un seul controller : tout est décalé dans le temps avec des Interval
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  );

  // Logo : zoom doux de 0.9 → 1.0 dans les 600 premières ms
  late final Animation<double> _logoScale = Tween(begin: 0.9, end: 1.0).animate(
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
      backgroundColor: AppColors.dark1,
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
                  padding: EdgeInsets.all(28.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36.r),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primaryLight, AppColors.primary],
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
                    color: AppColors.white,
                    size: 46,
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.h),

            // ---- Titre + sous-titre : fondu simple ----
            FadeTransition(
              opacity: _textFade,
              child: Column(
                children: [
                  Text(
                    'Smart Reminder',
                    style: GoogleFonts.roboto(
                      color: AppColors.white,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.8,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Votre assistant vocal pour\ntâches et rappels.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: AppColors.white.withValues(alpha: 0.45),
                      fontSize: 13.sp,
                      // height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 64.h),

            // ---- Barre de progression fine et discrète ----
            FadeTransition(
              opacity: _textFade,
              child: SizedBox(
                width: 140.w,
                height: 3.h,
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
                              height: 3.h,
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
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
