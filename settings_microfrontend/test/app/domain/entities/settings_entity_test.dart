import 'package:flutter_test/flutter_test.dart';
import 'package:settings_microfrontend/app/domain/entities/settings_entity.dart';

void main() {
  group('SettingsEntity', () {
    test('should create a SettingsEntity with given language', () {
      final settings = SettingsEntity(language: Language.pt);

      expect(settings.language, Language.pt);
    });
  });

  group('LanguageExtension', () {
    test('name should return correct value', () {
      expect(Language.system.name, 'system');
      expect(Language.pt.name, 'pt');
      expect(Language.en.name, 'en');
      expect(Language.es.name, 'es');
    });

    test('nameToUI should return correct value', () {
      expect(Language.system.nameToUI, 'System');
      expect(Language.pt.nameToUI, 'Português BR');
      expect(Language.en.nameToUI, 'English');
      expect(Language.es.nameToUI, 'Español');
    });
  });
}
