import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('GeneralLanguage', () {
    testWidgets('should return the current system language code',
        (WidgetTester tester) async {
      // Configurando uma localidade específica para o teste
      tester.binding.platformDispatcher.localeTestValue =
          const Locale('en', 'US');

      // Atuar
      final languageCode = GeneralLanguage.systemLanguage;

      // Verificar
      expect(languageCode, 'en');

      // Testar uma nova localidade
      tester.binding.platformDispatcher.localeTestValue =
          const Locale('es', 'ES');

      // Atuar novamente
      final newLanguageCode = GeneralLanguage.systemLanguage;

      // Verificar
      expect(newLanguageCode, 'es');
    });
  });
}
