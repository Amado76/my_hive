import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:settings_microfrontend/app/data/repositories/settings_language_repository_impl.dart';
import 'package:settings_microfrontend/app/domain/entities/settings_entity.dart';

class MockSecureLocalStorage extends Mock
    implements SecureLocalStorageInterface {}

void main() {
  late SettingsLanguageRepositoryImpl repository;
  late MockSecureLocalStorage mockLocalStorage;

  setUp(() {
    mockLocalStorage = MockSecureLocalStorage();
    repository =
        SettingsLanguageRepositoryImpl(settingsDataSource: mockLocalStorage);
  });

  group('SettingsLanguageRepositoryImpl', () {
    test('retrieve should return SettingsEntity with saved language', () async {
      when(
        () => mockLocalStorage.get(
          key: 'language',
        ),
      ).thenAnswer((_) async => 'Language.pt');

      final result = await repository.retrieve();

      expect(result.language, Language.pt);
    });

    test(
        'retrieve should return SettingsEntity with system language if no saved language',
        () async {
      when(
        () => mockLocalStorage.get(
          key: 'language',
        ),
      ).thenAnswer((_) async => null);

      final result = await repository.retrieve();

      expect(result.language, Language.system);
    });

    test('save should store the language in local storage', () async {
      when(
        () => mockLocalStorage.save(
          key: 'language',
          value: 'Language.en',
        ),
      ).thenAnswer(
        (_) async => Future.value(),
      );

      await repository.save(language: Language.en);

      verify(
        () => mockLocalStorage.save(
          key: 'language',
          value: 'Language.en',
        ),
      ).called(1);
    });
  });
}
