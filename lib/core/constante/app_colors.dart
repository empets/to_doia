import 'package:flutter/material.dart';

/// Palette centralisée de toute l'application.
///
/// ⚠️ Ne plus jamais utiliser `Color(0xFF...)` ni `Colors.x` dans les écrans :
/// importer ce fichier et référencer [AppColors].
class AppColors {
  AppColors._();

  // ---------- Primaires ----------
  /// Indigo principal de la marque.
  static const Color primary = Color(0xFF6366F1);

  /// Indigo clair (dégradés, highlights).
  static const Color primaryLight = Color(0xFF818CF8);

  /// Violet secondaire (dégradés, icônes).
  static const Color purple = Color(0xFF8B5CF6);

  /// Variantes d'accent secondaires.
  static const Color accent = Color(0xFF7965FF);
  static const Color accentBlue = Color(0xFF526BFF);

  // ---------- États ----------
  /// Vert succès / émeraude.
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);

  /// Rouge erreur / danger.
  static const Color error = Color(0xFFEF4444);
  static const Color errorDark = Color(0xFF8C1D18);

  /// Ambre avertissement.
  static const Color warning = Color(0xFFF59E0B);

  // ---------- Accents colorés (catégories, icônes) ----------
  static const Color cyan = Color(0xFF06B6D4);
  static const Color cyanNeon = Color(0xFF00D9FF);
  static const Color pink = Color(0xFFEC4899);
  static const Color magenta = Color(0xFFED59F5);
  static const Color orange = Color(0xFFFF7900);

  // ---------- Textes ----------
  /// Texte principal sur fond clair.
  static const Color ink = Color(0xFF1A1A2E);
  static const Color inkDark = Color(0xFF111827);
  static const Color inkAlt1 = Color(0xFF151A2E);
  static const Color inkAlt2 = Color(0xFF202130);
  static const Color inkAlt3 = Color(0xFF222222);

  /// Texte secondaire / muted.
  static const Color greyText = Color(0xFF6B7280);
  static const Color greyTextLight = Color(0xFF9CA3AF);
  static const Color grey1 = Color(0xFF888888);
  static const Color grey2 = Color(0xFF8D8D8D);

  // ---------- Fonds clairs / bordures ----------
  /// Fond de fond des écrans clairs.
  static const Color background = Color(0xFFF4F6FB);
  static const Color backgroundAlt1 = Color(0xFFF9FAFB);
  static const Color backgroundAlt2 = Color(0xFFF3F4F6);
  static const Color backgroundAlt3 = Color(0xFFF0F0F5);
  static const Color border = Color(0xFFE5E7EB);

  // ---------- Fond sombres ----------
  /// Fond sombre splash / écrans IA.
  static const Color dark1 = Color(0xFF0F0F1E);
  static const Color dark2 = Color(0xFF10111B);
  static const Color dark3 = Color(0xFF0C0F1D);

  // ---------- Couleurs de base ----------
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const MaterialColor grey = Colors.grey;
  static const MaterialColor red = Colors.red;
  static const MaterialColor green = Colors.green;
  static const MaterialColor blue = Colors.blue;
  static const MaterialColor yellow = Colors.yellow;
  static const MaterialColor brown = Colors.brown;
  static const MaterialColor teal = Colors.teal;
  static const MaterialColor lime = Colors.lime;
  static const MaterialColor indigo = Colors.indigo;
  static const MaterialColor amber = Colors.amber;
  static const MaterialAccentColor redAccent = Colors.redAccent;
  static const Color transparent = Colors.transparent;
  static const Color white54 = Colors.white54;

  // ---------- Overlays (couleurs const avec alpha) ----------
  /// `greyText` à 10 % — séparateurs sur fond clair.
  static const Color greyOverlay = Color(0x1A6B7280);

  /// `error` à 10 % — séparateurs sur fond clear-delete.
  static const Color redOverlay = Color(0x1AEF4444);

  // ---------- Badges de statut ----------
  static const Color successBg = Color(0XFFD7ECD7);
  static const Color warningBg = Color(0XFFFCE2CC);

  // ---------- Dégradés réutilisés ----------
  /// Dégradé indigo clair → primary (headers, cartes IA).
  static const List<Color> primaryGradient = [primaryLight, primary];

  /// Dégradé primary → violet (boutons CTA, splash).
  static const List<Color> purpleGradient = [primary, purple];
}
