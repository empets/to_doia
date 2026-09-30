import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

Future<bool> isEmulator() async {
  WidgetsFlutterBinding.ensureInitialized();

  final deviceInfoPlugin = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final androidInfo = await deviceInfoPlugin.androidInfo;

    // Liste des critères couramment utilisés pour détecter un émulateur Android
    const androidEmulators = [
      'generic',
      'google_sdk',
      'sdk',
      'sdk_x86',
      'vbox86p',
      'emulator',
    ];

    for (final item in androidEmulators) {
      if (androidInfo.fingerprint.contains(item) ||
          androidInfo.model.contains(item) ||
          androidInfo.hardware.contains(item) ||
          androidInfo.product.contains(item) ||
          androidInfo.brand.contains(item) ||
          androidInfo.device.contains(item)) {
        return true;
      }
    }
  } else if (Platform.isIOS) {
    final iosInfo = await deviceInfoPlugin.iosInfo;

    // Liste des critères couramment utilisés pour détecter un émulateur iOS
    const iosEmulators = [
      'x86_64', // simulateur iOS sur architectures Intel
      'arm64', // simulateur iOS sur architectures Apple Silicon (M1, M1 Pro, etc.)
    ];

    if (iosEmulators.contains(iosInfo.utsname.machine)) {
      return true;
    }
  }

  return false;
}

/// Vrai si l'appareil est altéré : émulateur/simulateur ([isEmulator])
/// ou rooté/jailbreaké (détecté par `jailbreak_root_detection`).
///
/// Centralise la logique utilisée à l'identique par les trois points
/// d'entrée (`main.dart`, `main_staging.dart`, `main_production.dart`)
/// pour décider d'afficher `AppRootJailbroken` au lieu de démarrer l'app.
///
/// `WidgetsFlutterBinding.ensureInitialized()` est appelé en premier ici
/// (et pas seulement dans [isEmulator]) car `JailbreakRootDetection.isNotTrust`
/// fait aussi un appel de plateforme (`MethodChannel`) et est évalué avant
/// `isEmulator()` par le `||` ci-dessous. Sans binding prêt, ce premier appel
/// échoue silencieusement (FlutterError en debug/profile, `Null check
/// operator used on a null value` en release — asserts supprimés en
/// release) et `isNotTrust` l'avale dans son propre try/catch en retournant
/// `true` par défaut : l'appareil est alors signalé comme compromis à tort,
/// sur tout device, dans les deux modes de build. Centraliser l'appel ici
/// (plutôt que dans chaque `main_*.dart`) protège tout futur call site de
/// `isDeviceCompromised()`, pas seulement `main_staging.dart` — voir
/// `openspec/changes/fix-jailbreak-check-binding-init-order/design.md`.

void closeKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

extension IterableExtension<T> on List<T> {
  Iterable<T> distinctBy(Object Function(T e) getCompareValue) {
    final idSet = <Object>{};
    final distinct = <T>[];
    for (final d in this) {
      if (idSet.add(getCompareValue(d))) {
        distinct.add(d);
      }
    }

    return distinct;
  }
}

extension OnlyDigits on String {
  String get digitsOnly => replaceAll(RegExp('[^0-9]'), '');
}



Color getNewstatutcolor(String statusBscs) {
  if (statusBscs.isEmpty) {
    return Colors.grey.withValues(alpha: .1);
  } else if (statusBscs.isNotEmpty && statusBscs.toLowerCase() == 'actif') {
    return const Color(0XFFD7ECD7);
  }
  return const Color(0XFFFCE2CC);
}

bool getNewStatusIconColor(String statusBscs) {
  if (statusBscs.isEmpty) {
    return false;
  } else if (statusBscs.isNotEmpty && statusBscs.toLowerCase() == 'actif') {
    return true;
  }
  return false;
}



Color getNewStatusTextColor(String statusBscs) {
  if (statusBscs.isEmpty) {
    return Colors.grey;
  } else if (statusBscs.isNotEmpty && statusBscs.toLowerCase() == 'actif') {
    return Colors.black;
  }
  return const Color(0xFF8C1D18);
}

extension CodeExtraction on String {
  String extractCode() {
    // Expression régulière pour trouver des codes alphanumériques avec des tirets
    final regex = RegExp(r'CINT-[A-Za-z0-9-]+\b');
    final Iterable<Match> matches = regex.allMatches(this);

    // Retourne le premier code trouvé (si existe)
    return matches.isNotEmpty ? matches.first.group(0) ?? '' : '';
  }
}

extension StringMasking on String {
  /// Remplace une portion de la chaîne par un autre texte
  /// Exemple : "1234567890".maskRange(2, 8, "** ** **") => "12** ** **90"
  String maskRange(int start, int end, String replacement) {
    if (isEmpty) return this;

    if (start < 0 || end > length || start > end) return this;
    return replaceRange(start, end, replacement);
  }
}

extension EmailValidator on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

String cleanText() {
  return replaceAll(r'\r\n', '\n')
      .replaceAll(r'\n', '\n')
      .replaceAll(r'\r', '\n')
      .replaceAll('.n', '. ') // .n littéral -> vrai saut de ligne
      .replaceAll(r"\'", "'")
      .replaceAll(r'\"', '"')
      .replaceAll(r'\\', r'\')
      .trim();
}

  bool isValidEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }

  bool isValidPassword() {
    return RegExp(r'^.{8,63}$').hasMatch(this);
    // return RegExp(
    //   r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$',
    // ).hasMatch(this);
  }

  bool isValidContact() {
    return RegExp(
      r'^(07|05|01|21)[0-9][0-9]{7}$',
    ).hasMatch(this);
  }

  bool isIdentifiantFibre() {
    return RegExp(
      r'^(27)[0-9][0-9]{7}$',
    ).hasMatch(this);
  }

  bool isValidPasswordPCMB2B() {
    // PCM B2B
    final regex = RegExp(
      r'^(?=.*[A-Z]{4,})(?=.*[a-z]{3,})(?=.*[0-9]{2,})(?=.*[!@#\$%^&*]{3,}).{12,}$',
    );

    return regex.hasMatch(this);
  }
}

extension GenericExtensions on Object? {
  T? asOrNull<T>() {
    final self = this;
    return self is T ? self : null;
  }
}

extension ListExtensions on Object? {
  Object? asEmptyList<T>() {
    final self = this;
    return self is T ? self : [];
  }
}

extension StringExtensions on String? {
  String getOrEmpty() {
    final self = this;
    return self is String ? self : '';
  }

  bool parseBool() {
    final self = this;
    return self?.toLowerCase() == 'true';
  }

  String splitText() {
    final self = this;
    if (self != null) {
      var tab = self.split(' ');
      if (tab.length > 1) {
        tab = tab.where((element) => element.isNotEmpty).toList();
        return '${tab[0]} ${tab[1][0].toUpperCase()}.';
      }
      return self;
    }
    return '';
  }

  String splitAddressText() {
    final self = this;
    if (self != null) {
      var tab = self.split(',');

      if (tab.length > 2) {
        tab = tab.where((element) => element.isNotEmpty).toList();
        return '${tab[0]} ${tab[1]}';
      } else if (tab.length > 1) {
        tab = tab.where((element) => element.isNotEmpty).toList();
        return tab[0];
      }
      return self;
    }
    return '';
  }

  bool isInCurrentMonth() {
    final self = this;

    if (self != null) {
      final now = DateTime.now();
      final date = DateFormat('dd/MM/yyyy').parse(self.replaceAll('-', '/'));
      return date.month == now.month && date.year == now.year;
    }
    return false;
  }

  int differenceTwoDate() {
    final self = this;
    if (self != null) {
      final end = DateFormat('yyyy/MM/dd').parse(self.replaceAll('-', '/'));
      return end.difference(DateTime.now()).inDays;
    }
    return 0;
  }

  String parseDate() {
    final self = this;
    if (self != null) {
      final parse = DateFormat('yyyy/dd/MM').parse(self.replaceAll('-', '/'));
      return DateFormat.yMd('fr_FR').format(parse);
    }
    return '';
  }

  DateTime parseDateToDateTime() {
    final self = this;
    if (self != null) {
      return DateFormat('yyyy/MM/dd').parse(self.replaceAll('-', '/'));
    }
    return DateTime.now();
  }
}

extension BoolExtensions on bool? {
  bool getOrEmpty() {
    final self = this;
    if (self == null) {
      return false;
    }
    return self;
  }
}

extension ParseAmountExtension on Object? {
  String parseAmount() {
    final value = this;
    if (value == null) return '';

    // Convertir en String pour nettoyage
    var str = value.toString().trim();

    // Nettoyer les caractères non numériques ou séparateurs
    str = str.replaceAll(RegExp(r'[^0-9\-,.]'), '');

    // Remplacer les virgules par des points si besoin
    if (str.contains(',') && !str.contains('.')) {
      str = str.replaceAll(',', '.');
    }

    final amount = num.tryParse(str);
    if (amount == null) return '';

    // Choisir le format en fonction de la taille
    final formatter = NumberFormat(
      amount.abs() >= 1000000 ? '#,##0.###' : '#,##0',
      'fr_FR',
    );

    // Formatter et remplacer la virgule par un espace
    return formatter.format(amount).replaceAll(',', ' ');
  }
}

// extension DoubleExtensions on double? {
//   String parseAmount() {
//     final self = this;
//     if (self == null) {
//       return '';
//     }
//     if (self == 0.0) {
//       return '0';
//     }
//     var formatter = NumberFormat('#,##0');
//     if (self.toString().length > 6) {
//       formatter = NumberFormat('# ##0.###');
//     }

//     final result =
//         formatter.format(double.tryParse(self.toString())).replaceAll(',', ' ');
//     return result;
//   }
// }

extension DoubleAmountExtensions on double? {
  String parseAmountTchat() {
    final self = this;
    var formatter = NumberFormat('#,##0');
    if (self.toString().length > 7) {
      formatter = NumberFormat('#,##0.###');
    }
    final result =
        formatter.format(double.tryParse(self.toString())).replaceAll(',', ' ');
    return result;
  }
}

extension IntExtensions on int? {
  int getOrEmpty() {
    final self = this;
    return self is int ? self : -1;
  }
}

extension JoursRestantsExtension on int {
  String joursRestantsLabel() {
    if (this <= 0) return "Expire aujourd'hui";
    if (this <= 30) {
      final unit = this == 1 ? 'jour restant' : 'jours restants';
      return '$this $unit';
    }
    if (this < 365) {
      final months = this ~/ 30;
      final unit = months == 1 ? 'mois restant' : 'mois restants';
      return '$months $unit';
    }
    final years = this ~/ 365;
    final unit = years == 1 ? 'an restant' : 'ans restants';
    return '$years $unit';
  }
}

extension DoubleExtension on double? {
  double getOrEmpty() {
    final self = this;
    return self is double ? self : 0.0;
  }
}

extension Utility on BuildContext {
  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (FocusScope.of(this).focusedChild!.context == null);
  }

  /// True si le contexte est attaché à la route visible au sommet de la pile.
  ///
  /// Usage : guard des listeners qui naviguent — empêche les pages
  /// empilées/cachées de réagir aux états d'un bloc partagé.
  bool get isCurrentRoute {
    if (!mounted) return false;
    final route = ModalRoute.of(this);
    return route?.isCurrent ?? false;
  }
}

extension DateTimeExtension on DateTime {
  String get toDotSeparatedString => DateFormat('dd/MM/yyyy').format(this);
  String get timeFormat =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  String get formatDate => '$toDotSeparatedString $timeFormat';

  DateTime getDay({required int dayOfWeek}) {
    return subtract(Duration(days: weekday - dayOfWeek));
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String get timeFormat =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}

String formaterDate(String dateString) {
  // Format d’entrée (comme dans ton exemple)
  final inputFormat = DateFormat('dd/MM/yyyy HH:mm:ss');

  // Conversion en objet DateTime
  final date = inputFormat.parse(dateString);

  // Format de sortie en français
  final outputFormat = DateFormat("EEEE d MMMM yyyy 'à' HH'h'mm", 'fr_FR');

  // On retourne la date formatée avec majuscule au début
  final result = outputFormat.format(date);
  return '${result[0].toUpperCase()}${result.substring(1)}';
}

class EllipsisFormatter extends TextInputFormatter {
  EllipsisFormatter({this.maxLength = 25});
  final int maxLength; // longueur max souhaitée

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    if (text.length <= maxLength) {
      return newValue;
    }

    // Coupe le texte et ajoute ...
    final shortened = '${text.substring(0, maxLength)}...';

    return TextEditingValue(
      text: shortened,
      selection: TextSelection.collapsed(offset: shortened.length),
    );
  }
}

String couperAdresse(String adresse, int n) {
  // Découpe la chaîne par virgule
  final parties = adresse.split(',').map((p) => p.trim()).toList();

  // Si n est plus grand que le nombre d'éléments, on renvoie tout
  if (n >= parties.length) {
    return parties.join(', ');
  }

  // Sinon on renvoie seulement les n premiers éléments
  return parties.sublist(0, n).join(', ');
}

extension FrenchColorExtension on String {
  Color toColor() {
    final value = trim().toLowerCase();

    switch (value) {
      case 'rouge':
        return Colors.red;
      case 'vert':
        return Colors.green;
      case 'bleu':
        return Colors.blue;
      case 'jaune':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'noir':
        return Colors.black;
      case 'blanc':
        return Colors.white;
      case 'gris':
        return Colors.grey;
      case 'rose':
        return Colors.pink;
      case 'violet':
        return Colors.purple;
      case 'marron':
      case 'brun':
        return Colors.brown;
    }

    return Colors.transparent;
  }
}

String removeLetters(String text) {
  return text.replaceAll(RegExp('[^MmNnGg0-9]'), '');
}
/// cette methode permet de recupéer le chiffre ainsi que la lettre qui le suit 
/// par exemple : Offre fibre 1G max -> 1G
String extractDigitAndLetter(String text) {
  return RegExp(r'\d[a-zA-Z]').allMatches(text).map((m) => m.group(0)!).join();
}

// extension AppStylesExtension on BuildContext {
//   AppStyles get styles => Theme.of(this).extension<AppStyles>()!;
// }

extension DossierExtraction on String {
  /// Extrait le numéro de dossier depuis un texte du type :
  /// "Numero de Dossier: 64234411"
  String? get dossierNumber {
    final regex = RegExp(r':\s*(\d+)');
    final match = regex.firstMatch(this);

    return match?.group(1);
  }
}

bool isValidDate(String dateStr) {
  if (dateStr.isEmpty) {
    return true;
  }
  final date = DateFormat('dd/MM/yyyy HH:mm:ss').parse(dateStr);
  return DateTime.now().difference(date).inDays >= 30;
}

String getDate30Formatted(String dateStr) {
  final date = DateFormat('dd/MM/yyyy HH:mm:ss').parse(dateStr);
  return DateFormat('dd/MM/yyyy HH:mm:ss')
      .format(date.add(const Duration(days: 30)));
}

/// Check if BSCS status is inactive
/// Returns true if status is empty or not contains 'Actif'
bool isBscsInactive(String? statusBscs) {
  return statusBscs.getOrEmpty().isEmpty ||
      !statusBscs.getOrEmpty().contains('Actif');
}


/// Mask phone number
/// Example: 1234567890 -> 12****7890
String maskPhoneNumber(String phoneNumber) {
  if (phoneNumber.length != 10) {
    return phoneNumber;
  }

  return '${phoneNumber.substring(0, 2)}'
      '●●●●'
      '${phoneNumber.substring(6)}';
}

/// Format phone number to mask middle digits
/// Example: +225 0712345678 -> +225 07 •••• 5678
String formatMaskedPhone(String phone) {
  final digits = phone.replaceAll(RegExp(r'\D'), '');

  if (digits.length != 10) return phone;

  return '+225 ${digits.substring(0, 2)} •••• ${digits.substring(6)}';
}


extension CoordinateExtension on double {
  bool get isUnsetCoordinate => this == 0.0;

  bool get isValidCoordinate => this != 0.0;
}

extension AddressCleanerExtension on String {
  /// Nettoie une adresse complète pour n'en garder que le nom de lieu lisible.
  ///
  /// Supprime les codes postaux (numériques ou format "BP") et le dernier
  /// élément (généralement le pays), pour ne conserver que rue, quartier et commune.
  ///
  /// Exemples :
  /// - "Rue des Jardins, 75001, Cocody, Abidjan, Côte d'Ivoire"
  ///   → "Rue des Jardins, Cocody, Abidjan"
  /// - "Cocody, Abidjan, Côte d'Ivoire"
  ///   → "Cocody, Abidjan"
  /// - "Cocody" → "Cocody" (inchangé)
  String get cleanLocationName {
    final parts =
        split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    if (parts.isEmpty) return this;

    final filtered = parts.where((part) {
      final isNumericOnly = RegExp(r'^[\d\s]+$').hasMatch(part);
      final isPostalBox = part.toUpperCase().contains('BP');
      return !isNumericOnly && !isPostalBox;
    }).toList();

    if (filtered.isEmpty) return parts.first;

    if (filtered.length <= 2) return filtered.join(', ');

    return filtered.sublist(0, filtered.length - 1).join(', ');
  }
}

DateTime parseDate(String date) {
  try {
    return DateFormat('dd/MM/yyyy HH:mm:ss').parse(date);
  } catch (_) {
    return DateFormat('dd/MM/yyyy HH:mm').parse(date);
  }
}

String formatDateOnly(String date) {
  final dateTime = parseDate(date);

  return DateFormat(
    'd MMMM y',
    'fr',
  ).format(dateTime);
}

String formatTimeDifference(String date) {
  final dateTime = parseDate(date);
  final now = DateTime.now();
  final diff = now.difference(dateTime);

  if (diff.inSeconds < 60) {
    return "À l'instant";
  }

  if (diff.inMinutes < 60) {
    return "Il y a ${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''}";
  }

  if (diff.inHours < 24) {
    return "Hier, ${diff.inHours} heure${diff.inHours > 1 ? 's' : ''}";
  }

  if (diff.inDays < 7) {
    return 'Il y a ${diff.inDays} jours';
  }

  return 'Le ${formatDateOnly(date)}';
}

// cette methode permet d'afficher la date par catégorie (aujourd'hui, hier, semaine, les plus ancien)
String formatSmartDate(String date) {
  final dateTime = DateFormat(
    'dd/MM/yyyy HH:mm:ss',
  ).parse(date);

  final now = DateTime.now();

  final today = DateTime(
    now.year,
    now.month,
    now.day,
  );

  final targetDate = DateTime(
    dateTime.year,
    dateTime.month,
    dateTime.day,
  );

  // Aujourd'hui
  if (targetDate == today) {
    return "Aujourd'hui";
  }

  // Hier
  final yesterday = today.subtract(
    const Duration(days: 1),
  );

  if (targetDate == yesterday) {
    return 'Hier';
  }

  // Début de la semaine actuelle : lundi
  final startOfWeek = today.subtract(
    Duration(days: today.weekday - 1),
  );

  // Fin de la semaine actuelle : dimanche
  final endOfWeek = startOfWeek.add(
    const Duration(days: 6),
  );

  // Cette semaine
  if (!targetDate.isBefore(startOfWeek) && !targetDate.isAfter(endOfWeek)) {
    return 'Cette semaine';
  }

  // Tout ce qui est avant la semaine actuelle
  return 'Plus ancien';
}

// String formatTimeDifferenceWithTime(String date) {
//   final dateTime = parseDate(date);
//   final now = DateTime.now();
//   final diff = now.difference(dateTime);

//   // Extraire l'heure au format HH:mm
//   final time =
//       "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

//   if ( diff.inSeconds < 10) {
//     return "$time";
//   }

//   if (diff.inMinutes < 60) {
//     return "Il y a ${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''}";
//   }

//   // Aujourd'hui (< 24h)
//   if (diff.inHours < 24 && now.day == dateTime.day) {
//     return time;
//   }

//   // Hier
//   if (diff.inDays == 0) {
//     return 'Hier à $time';
//   }

//   // Cette semaine (< 7 jours)
//   if (diff.inDays < 7) {
//     final days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
//     final dayName = days[dateTime.weekday - 1];
//     return '$dayName, $time';
//   }

//   return 'Le ${formatDateOnly(date)}';
// }

String formatTimeDifferenceWithTime(String date) {
  final dateTime = parseDate(date);
  final now = DateTime.now();
  final diff = now.difference(dateTime);

  final time =
      "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

  // Moins de 60 secondes
  if (diff.inSeconds < 60) {
    return ' $time';
  }

  // Entre 1 min et 60 min
  if (diff.inMinutes < 60) {
    return "Il y a ${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} - $time";
  }

  // Même jour
  if (now.day == dateTime.day) {
    return time;
  }

  // Jour différent (Hier)
  if (now.day != dateTime.day) {
    return 'Hier à $time';
  }

  // Cette semaine (< 7 jours)
  if (diff.inDays < 7) {
    final days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
    final dayName = days[dateTime.weekday - 1];
    return '$dayName à $time';
  }

  return 'Le ${formatDateOnly(date)}';
}

/// Supprime le premier chiffre et tout ce qui vient après
/// Si aucun chiffre n'est trouvé, retourne le texte complet
/// Exemple "Bonjour 123 monde 456" → "Bonjour"
/// Exemple "Pas de chiffre" → "Pas de chiffre"
String removeFromFirstDigit(String text) {
  final regex = RegExp(r'\d[\s\S]*');
  if (regex.hasMatch(text)) {
    return text.replaceFirst(regex, '').trim();
  }
  return text;
}

/// Extrait uniquement les nombres avec unités M ou Gb d'une phrase
/// Exemple Télécharger 500 MB
/// Résultat 500 MB
String extractNumbersWithUnits(String text) {
  final regex = RegExp(
    r'\d+(?:\.\d+)?\s*(?:M|Gb|MB|GB|m|gb|mb)',
    caseSensitive: false,
  );
  final match = regex.firstMatch(text);
  return match?.group(0) ?? '';
}

String extractDebit(String offreDebit) {
  final regex = RegExp(r'(\d+)\s*(M|GB|Gb)', caseSensitive: false);
  final match = regex.firstMatch(offreDebit);

  if (match == null) return '';
  final valeur = match.group(1);
  final unite = match.group(2)!.toUpperCase();

  return '$valeur${unite == 'GB' ? 'gb' : 'mb'}/s'.toLowerCase();
}

String getOffreDebitIcon({required String offreDebit}) {
  final debit = extractDebit(offreDebit);

  const debitIndexMap = {
    '50mb/s': 1,
    '100mb/s': 2,
    '200mb/s': 3,
    '300mb/s': 3,
    '500mb/s': 4,
    '1gb/s': 5,
  };

  final index = debitIndexMap[debit] ?? 2;
  return 'assets/images/request_management/icons/$index.svg';
}

String extractPrixClean(String priceString) {
  final regex = RegExp(r'(\d+[.,]?\d*)');
  final match = regex.firstMatch(priceString);

  if (match == null) return '';
  return match.group(1)!.replaceAll(',', ''); // Enlève les virgules
}

int extractPrix(String priceString) {
  final regex = RegExp(r'(\d+)');
  final matches = regex.allMatches(priceString);

  if (matches.isEmpty) return 0;
  final prix = matches.map((m) => m.group(0)).join('');
  return int.parse(prix);
}

bool offreDebit(String offreDebitValue) {
  switch (offreDebitValue.toLowerCase()) {
    case '50m':
      return true;
    case '100m':
      return true;
    case '200m':
      return true;
    case '500m':
      return true;
    case '1gb':
      return false;
    default:
      return true;
  }
}

///
///// Utilisation
/// final number = extractNumber("20.5M");  // 20
/// final number = extractNumber("10G");    // 10
int extractNumber(String value) {
  return int.tryParse(value.replaceAll(RegExp('[^0-9]'), '')) ?? 0;
}



/// Cette fonction applique une logique de formatage temporel pour notifications comme WhatsApp/Telegram.
String formatNotificationTime(String createdAtString) {
  try {
    final createdAt = DateFormat('dd/MM/yyyy HH:mm:ss').parse(createdAtString);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final createdDay = DateTime(createdAt.year, createdAt.month, createdAt.day);
    final timeStr = DateFormat('HH:mm').format(createdAt);
    final daysAgo = today.difference(createdDay).inDays;

    return switch (daysAgo) {
      0 => timeStr, // Aujourd'hui
      1 => 'Hier à $timeStr',
      2 => // Avant-hier (jour de la semaine)
        '${DateFormat('EEE', 'fr_FR').format(createdAt).capitalize()} '
            'à $timeStr',
      _ => // Plus ancien (date complète)
        DateFormat('EEE. à d MMM', 'fr_FR').format(createdAt).capitalize(),
    };
  } catch (e) {
    return 'Date invalide';
  }
}










// cette methode permet de retier que le nombre de jour
// dans une phrase. je l'utilise dans PinpadSucessOffreFlexible
// exemple : Passe Duo 1 jour
// resultat: 1 jour
String extractNombreEtJours(String text) {
  final match = RegExp(
    r'\d+\s*jours?',
    caseSensitive: false,
  ).firstMatch(text);

  return match?.group(0) ?? '';
}

/// Extrait l'identifiant du texte.
///
/// - Si "REC" est présent: retourne "REC" suivi des nombres
/// - Sinon: retourne uniquement les nombres
///
/// Exemples:
/// - "Votre demande numéro REC18092026144640 est en cours." → "REC18092026144640"
/// - "Numero de Dossier: 70425241." → "70425241"
/// - "Aucun identifiant ici" → null
///
/// Paramètres:
///   [text] - La chaîne de caractères à analyser
///
/// Retourne:
///   L'identifiant trouvé (String) ou null si aucun identifiant n'existe.
String? extractIdentifier(String text) {
  // Cherche "REC" suivi de chiffres
  final recRegex = RegExp(r'REC\d+');
  final recMatch = recRegex.firstMatch(text);

  if (recMatch != null) {
    return recMatch.group(0); // Retourne "REC" + les chiffres
  }

  // Si pas de "REC", cherche uniquement les chiffres
  final numberRegex = RegExp(r'\d+');
  final numberMatch = numberRegex.firstMatch(text);

  return numberMatch?.group(0); // Retourne les chiffres ou null
}

bool tousDesNombres(String input) {
  final RegExp allNumbers = RegExp(r'^\s*\d+(\s*,\s*\d+)*\s*$');
  return allNumbers.hasMatch(input);
}


/// Formate la date de création d'une notification selon son ancienneté.
///
/// - Aujourd'hui : affiche uniquement l'heure (`11:00`).
/// - Hier : affiche `Hier à 11:00`.
/// - Cette semaine : affiche le jour et l'heure (`Mer à 11:00`).
/// - Notifications anciennes : affiche le jour, la date, le mois et l'heure
///   (`Mer 24 sept à 11:00`).
///
/// Retourne `Date invalide` si la date fournie ne peut pas être analysée.
String formatNotificationTimer(String createdAtString) {
  try {
    final createdAt = DateFormat(
      'dd/MM/yyyy HH:mm:ss',
    ).parse(createdAtString);

    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final createdDay = DateTime(
      createdAt.year,
      createdAt.month,
      createdAt.day,
    );

    final timeStr = DateFormat('HH:mm').format(createdAt);

    final daysAgo = today.difference(createdDay).inDays;

    // Aujourd'hui
    if (daysAgo == 0) {
      return timeStr;
    }

    // Hier
    if (daysAgo == 1) {
      return 'Hier à $timeStr';
    }

    // Cette semaine
    final startOfWeek = today.subtract(
      Duration(days: today.weekday - 1),
    );

    if (!createdDay.isBefore(startOfWeek)) {
      return '${DateFormat('EEE', 'fr_FR').format(createdAt).capitalize()} '
          'à $timeStr';
    }

    // Notifications anciennes
    return '${DateFormat('EEE', 'fr_FR').format(createdAt).capitalize()} '
        '${DateFormat('d MMM', 'fr_FR').format(createdAt)} '
        'à $timeStr';
  } catch (e) {
    return 'Date invalide';
  }
}