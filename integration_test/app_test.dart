import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:grace_church/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('parcours utilisateur de démarrage et navigation principale', (
    tester,
  ) async {
    app.main();

    // L'application affiche le splash pendant 2,6 secondes.
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Smart Reminder'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pump(const Duration(milliseconds: 500));

    // Ne pas demander les permissions système pendant un test automatisé.
    expect(find.text('Autoriser le\nmicrophone'), findsOneWidget);
    await tester.tap(find.text('Continuer sans microphone'));
    await tester.pump(const Duration(milliseconds: 700));

    expect(find.text('Activer les\nnotifications'), findsOneWidget);
    await tester.tap(find.text('Continuer sans notifications'));
    await tester.pump(const Duration(milliseconds: 700));

    // Navigation utilisateur via la barre du bas.
    expect(find.text('Accueil'), findsOneWidget);
    expect(find.text('Tâches'), findsOneWidget);
    expect(find.text('Paramètres'), findsOneWidget);

    await tester.tap(find.text('Tâches'));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Tâches'), findsWidgets);

    await tester.tap(find.text('Paramètres'));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Paramètres'), findsWidgets);

    await tester.tap(find.text('Accueil'));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Accueil'), findsWidgets);
  });
}