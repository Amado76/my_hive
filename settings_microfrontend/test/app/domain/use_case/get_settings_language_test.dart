import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:settings_microfrontend/app/domain/entities/settings_entity.dart';
import 'package:settings_microfrontend/app/domain/interfaces/settings_language_repository_interface.dart';
import 'package:settings_microfrontend/app/domain/use_case/get_settings_language.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingsLanguageRepository extends Mock
    implements SettingsLanguageRepositoryInterface {}

void main() {
  late GetSettingsLanguageUseCase useCase;
  late MockSettingsLanguageRepository mockRepository;

  setUp(() {
    mockRepository = MockSettingsLanguageRepository();
    useCase = GetSettingsLanguageUseCase(mockRepository);
  });

  group('GetSettingsLanguageUseCase', () {
    test('should return system language code when language is set to system',
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      when(
        () => mockRepository.retrieve(),
      ).thenAnswer(
        (_) async => SettingsEntity(
          language: Language.system,
        ),
      );

      final result = await useCase();

      expect(result,
          WidgetsBinding.instance.platformDispatcher.locale.languageCode);
    });

    test('should return the correct language name when language is not system',
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      when(
        () => mockRepository.retrieve(),
      ).thenAnswer(
        (_) async => SettingsEntity(
          language: Language.pt,
        ),
      );

      final result = await useCase();

      expect(result, 'pt');
    });
  });
}
