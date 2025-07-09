import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nu_challenge/main.dart' as app;

void main() {
  final IntegrationTestWidgetsFlutterBinding binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End Test', () {
    testWidgets('Shorten URL flow and capture screenshots', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await binding.takeScreenshot('01-initial-state.png');

      final urlTextField = find.byType(TextField);
      final shortenButton = find.byIcon(Icons.arrow_forward);

      await tester.enterText(urlTextField, 'https://flutter.dev');
      await tester.tap(shortenButton);

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 5));
      await binding.takeScreenshot('02-after-url-shortened.png');
      await tester.enterText(urlTextField, 'https://google.com');
      await tester.tap(shortenButton);

      await tester.pumpAndSettle(const Duration(seconds: 5));

      await binding.takeScreenshot('03-after-url-shortened2.png');

      expect(find.text('https://flutter.dev'), findsOneWidget);
      expect(find.text('https://google.com'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
