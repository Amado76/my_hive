import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:common_microfrontend/util/theme_and_colors/data/theme_dto.dart';
import 'package:common_microfrontend/util/theme_and_colors/domain/interfaces/theme_repository_interface.dart';
import 'package:mocktail/mocktail.dart';

class MockThemeRepository extends Mock implements ThemeRepositoryInterface {}

void main() {
  group('ChangeThemeUsecase', () {
    late MockThemeRepository mockThemeRepository;
    late ChangeThemeUsecase changeThemeUsecase;

    setUp(() {
      mockThemeRepository = MockThemeRepository();
      changeThemeUsecase =
          ChangeThemeUsecase(themeRepository: mockThemeRepository);
    });

    test('should call getTheme and return ThemeDto', () async {
      // Configurando o mock para retornar um ThemeDto específico
      final themeDto = ThemeDto(
        gradientPrimaryMain: '0xFF123456',
        gradientSecondaryMain: '0xFF654321',
        primary: '0xFF123456',
        secondary: '0xFF654321',
        text: 'text',
        background: 'https://example.com/background.png',
        logoUrl: 'https://example.com/logo.png',
      );

      when(() => mockThemeRepository.getTheme())
          .thenAnswer((_) async => themeDto);

      // Executando o teste
      final result = await changeThemeUsecase();

      // Verificações
      verify(() => mockThemeRepository.getTheme()).called(1);
      expect(result, equals(themeDto));
      expect(result!.primary, equals('0xFF123456'));
    });

    test('should handle null return from repository', () async {
      when(() => mockThemeRepository.getTheme()).thenAnswer((_) async => null);

      // Executando o teste
      final result = await changeThemeUsecase();

      // Verificações
      verify(() => mockThemeRepository.getTheme()).called(1);
      expect(result, isNull);
    });
  });
}
