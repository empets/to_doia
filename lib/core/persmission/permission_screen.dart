import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// Écran des permissions — design immersif :
/// fond nuit avec halo animé derrière l'icône, navigation entre étapes en
/// glissement horizontal fluide, bouton piluel avec couleur animée.
///
/// La logique de permissions (demande réelle, réglages, skip) est inchangée.
class PermissionsScreen extends StatefulWidget {
  final VoidCallback onDone;
  const PermissionsScreen({super.key, required this.onDone});
  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen>
    with TickerProviderStateMixin {
  static const Color _night = Color(0xFF0C0F1D);
  static const Color _panel = Color(0xFF151A2E);

  int _step = 0; // 0 = micro, 1 = notifications
  bool _busy = false;

  // ── Apparition de la page (en une seule nappe, décalée) ──
  late final AnimationController _intro = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  // ── Halo qui respire derrière l'icône ──
  late final AnimationController _breathe = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  )..repeat(reverse: true);

  // ── Transition d'étape : glissement horizontal ──
  late final AnimationController _swap = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 520),
  );

  // Entrée globale
  late final Animation<double> _introOpacity = CurvedAnimation(
    parent: _intro,
    curve: Curves.easeOut,
  );

  final _steps = [
    {
      'icon': Icons.mic_rounded,
      'color': Color(0xFF818CF8),
      'title': 'Autoriser le\nmicrophone',
      'desc':
          'Le microphone est utilisé pour transformer votre voix en tâches. '
          'Aucun enregistrement n\'est conservé.',
      'btn': 'Autoriser le microphone',
      'skip': 'Continuer sans microphone',
    },
    {
      'icon': Icons.notifications_rounded,
      'color': Color(0xFF34D399),
      'title': 'Activer les\nnotifications',
      'desc':
          'Autorisez les notifications pour recevoir vos rappels au bon '
          'moment, même lorsque l\'application est fermée.',
      'btn': 'Activer les notifications',
      'skip': 'Continuer sans notifications',
    },
  ];

  Permission get _currentPermission =>
      _step == 0 ? Permission.microphone : Permission.notification;

  @override
  void initState() {
    super.initState();
    _intro.forward();
  }

  @override
  void dispose() {
    _intro.dispose();
    _breathe.dispose();
    _swap.dispose();
    super.dispose();
  }

  // ══════════════════════ LOGIQUE PERMISSIONS (inchangée) ══════════════════════

  Future<void> _requestPermission() async {
    if (_busy) return;
    setState(() => _busy = true);

    PermissionStatus status;
    try {
      status = await _currentPermission.request();
    } catch (_) {
      // Ne jamais bloquer l'utilisateur si la permission n'est pas disponible
      // sur la plateforme (ex. notifications iOS sans configuration).
      status = PermissionStatus.denied;
    }

    if (!mounted) return;

    setState(() {
      _busy = false;
    });

    if (status.isGranted || status.isLimited || status.isProvisional) {
      _next();
      return;
    }

    if (status.isPermanentlyDenied || status.isRestricted) {
      await _showSettingsDialog();
      return;
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: _panel,
          content: Text(
            _step == 0
                ? 'Microphone refusé. Vous pourrez l\'autoriser plus tard.'
                : 'Notifications refusées. Vous pourrez les autoriser plus tard.',
          ),
        ),
      );
    }
  }

  Future<void> _showSettingsDialog() async {
    if (!mounted) return;
    final open = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _panel,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          'Autorisation bloquée',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          _step == 0
              ? 'Le microphone est bloqué. Ouvrez les réglages pour l\'autoriser.'
              : 'Les notifications sont bloquées. Ouvrez les réglages pour les autoriser.',
          style: const TextStyle(color: Color(0xFF9CA3AF), height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Plus tard',
              style: TextStyle(color: Color(0xFF6B7280)),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ouvrir les réglages'),
          ),
        ],
      ),
    );
    if (open == true) {
      await openAppSettings();
    }
  }

  void _next() {
    if (_step < _steps.length - 1) {
      setState(() => _step++);
      _swap.forward(from: 0);
    } else {
      widget.onDone();
    }
  }

  // ══════════════════════ UI ══════════════════════

  @override
  Widget build(BuildContext context) {
    final s = _steps[_step];
    final color = s['color'] as Color;
    final isLast = _step == _steps.length - 1;

    return Scaffold(
      backgroundColor: _night,
      body: FadeTransition(
        opacity: _introOpacity,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
            child: Column(
              children: [
                // Progression en haut
                _buildPageIndicators(color, isLast),

                const Spacer(),

                // Bloc icône + textes, centré verticalement
                _buildSwappingContent(s, color),

                const Spacer(),

                // Actions en bas
                _buildMainButton(s, color),
                const SizedBox(height: 10),
                _buildFooterActions(s, isLast),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Points de progression (largeur animée, style « pill ») ──

  Widget _buildPageIndicators(Color color, bool isLast) {
    return Stack(
      children: [
        Row(
          children: List.generate(_steps.length, (i) {
            final active = i <= _step;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeOutCubic,
              height: 5,
              margin: const EdgeInsets.only(right: 7),
              width: i == _step ? 34 : 14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: active
                    ? (isLast ? Color(0xFF34D399) : Color(0xFF818CF8))
                    : Colors.white.withValues(alpha: 0.12),
              ),
            );
          }),
        ),
      ],
    );
  }

  // ── Contenu qui glisse horizontalement à chaque étape ──

  Widget _buildSwappingContent(Map<String, Object> s, Color color) {
    return AnimatedBuilder(
      animation: _swap,
      builder: (context, child) {
        final t = Curves.easeOutCubic.transform(_swap.value);
        // L'étape 0 entre depuis la gauche, l'étape 1 depuis la droite
        final dir = _step == 1 ? 1.0 : -1.0;
        final offset = Offset(dir * (1.0 - t) * 0.35, 0);

        return Transform.translate(
          offset: offset,
          child: Opacity(opacity: t, child: child),
        );
      },
      child: Column(
        children: [
          // Icône avec halo lumineux qui respire, directement derrière
          Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _breathe,
                builder: (context, _) {
                  final t =
                      0.92 + 0.08 * Curves.easeInOut.transform(_breathe.value);
                  return Transform.scale(
                    scale: t,
                    child: Container(
                      width: 330,
                      height: 330,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            color.withValues(alpha: 0.28),
                            color.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              Transform.scale(
                scale: Curves.easeOutBack.transform(
                  _intro.value < 0.6 ? _intro.value / 0.6 : 1.0,
                ),
                child: Container(
                  width: 104,
                  height: 104,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [color, color.withValues(alpha: 0.55)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.45),
                        blurRadius: 45,
                        spreadRadius: 6,
                      ),
                    ],
                  ),
                  child: Icon(
                    s['icon'] as IconData,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Titre sur deux lignes
          Text(
            s['title'] as String,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w800,
              height: 1.15,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            s['desc'] as String,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.45),
              fontSize: 14.5,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }

  // ── Bouton pilule principal ──

  Widget _buildMainButton(Map<String, Object> s, Color color) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: _busy ? 0.65 : 1.0,
      child: SizedBox(
        width: double.infinity,
        height: 58,
        child: ElevatedButton(
          onPressed: _busy ? null : _requestPermission,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: const Color(0xFF0C0F1D),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(29),
            ),
          ),
          child: _busy
              ? SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    color: const Color(0xFF0C0F1D),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        s['btn'] as String,
                        style: const TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const Icon(Icons.arrow_forward_rounded, size: 22),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  // ── Actions secondaires ──

  Widget _buildFooterActions(Map<String, Object> s, bool isLast) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: _busy ? null : _next,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            child: Text(
              s['skip'] as String,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.35),
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: _busy ? null : openAppSettings,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.settings_rounded,
                  size: 14,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
                const SizedBox(width: 5),
                Text(
                  'Réglages système',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.3),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
