// Criando mocks
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:common_microfrontend/util/theme_and_colors/data/theme_dto.dart';
import 'package:common_microfrontend/util/theme_and_colors/data/theme_repository_imp.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClientInterface extends Mock implements DioAdapter {}

class MockUrlInjector extends Mock implements UrlInjector {}

void main() {
  group('ThemeRepositoryImp', () {
    late MockHttpClientInterface mockHttpClient;
    late MockUrlInjector mockUrlInjector;
    late ThemeRepositoryImp themeRepository;

    setUp(() {
      mockHttpClient = MockHttpClientInterface();
      mockUrlInjector = MockUrlInjector();
      themeRepository = ThemeRepositoryImp(
        httpClientAdapter: mockHttpClient,
        urlInjector: mockUrlInjector,
      );
    });

    test('getTheme fetches and converts theme data correctly', () async {
      // Configurando o ambiente de mock
      when(() => mockUrlInjector.getEndPoint(
            endpoint: 'current_theme',
            package: 'theme_and_colors',
          )).thenReturn('http://api.example.com/current_theme');
      when(() => mockHttpClient.get(
            path: 'http://api.example.com/current_theme',
          )).thenAnswer((_) async => (
            data: {
              'data': {
                'gradient': {
                  'primaryMain': '0xFF123456',
                  'secondaryMain': '0xFF654321',
                },
                'primary': '0xFF654321',
                'secondary': '0xFF123456',
                'text': 'text',
                'background': 'http://example.com/background',
                'logo_url': 'http://example.com/logo.png',
              },
            },
            statusCode: 200
          ));

      // Executando o teste
      final themeDto = await themeRepository.getTheme();

      // Verificações
      verify(() => mockUrlInjector.getEndPoint(
            endpoint: 'current_theme',
            package: 'theme_and_colors',
          )).called(1);
      verify(() => mockHttpClient.get(
            path: 'http://api.example.com/current_theme',
          )).called(1);
      expect(themeDto, isA<ThemeDto>());
      expect(themeDto!.gradientPrimaryMain, '0xFF123456');
    });
  });
}
