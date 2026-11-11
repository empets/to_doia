import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/constante/app_colors.dart';
import 'package:grace_church/core/navigation/shara_route.dart';

/// ── Shell des 3 onglets principaux ──────────────────────────────────────────
///
///(\"home\", \"tasks\", \"settings\") donne la barre du bas commune —
/// cohérente avec `_goNav(0/1/2)` de l'ancienne machine d'état.
class SharaNavShell extends StatelessWidget {
  const SharaNavShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _buildNav(),
    );
  }

  Widget _buildNav() {
    const items = [
      (Icons.home_rounded, Icons.home_outlined, 'Accueil', SharaRoute.home),
      (
        Icons.task_alt_rounded,
        Icons.check_circle_outline,
        'Tâches',
        SharaRoute.tasks,
      ),
      (
        Icons.settings_rounded,
        Icons.settings_outlined,
        'Paramètres',
        SharaRoute.settings,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((e) {
              final active = navigationShell.currentIndex == e.key;
              return GestureDetector(
                onTap: () => _goBranch(e.key),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 4,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        active ? e.value.$1 : e.value.$2,
                        color: active
                            ? AppColors.primary
                            : AppColors.greyText,
                        size: 24,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        e.value.$3,
                        style: GoogleFonts.roboto(
                          color: active
                              ? AppColors.primary
                              : AppColors.greyText,
                          fontSize: 11.sp,
                          fontWeight: active
                              ? FontWeight.w700
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  /// Rebranche vers l'onglet, en revoyant à sa racine au 2e clic
  /// (navigation cohérente avec iOS).
  void _goBranch(int index) => navigationShell.goBranch(
    index,
    initialLocation: index == navigationShell.currentIndex,
  );
}

/// ── Enrobage des sous-écrans Paramètres (bouton retour) ─────────────────────
class SubSettingScaffold extends StatelessWidget {
  const SubSettingScaffold({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.transparent,
        foregroundColor: AppColors.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: GestureDetector(
          onTap: () => context.go(SharaRoute.settings),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.chevron_left_rounded,
              color: AppColors.primary,
            ),
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.roboto(
            color: AppColors.ink,
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: child,
    );
  }
}
