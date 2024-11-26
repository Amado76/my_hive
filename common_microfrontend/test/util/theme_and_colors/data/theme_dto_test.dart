import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/util/theme_and_colors/data/theme_dto.dart'; // Atualize o caminho de importação conforme necessário

void main() {
  group('ThemeDto', () {
    test('creates an instance with provided values', () {
      final themeDto = ThemeDto(
        gradientPrimaryMain: '0xFF123456',
        gradientSecondaryMain: '0xFF654321',
        primary: '0xFF123456',
        secondary: '0xFF654321',
        text: '0xFFabcdef',
        background: '0xFFfedcba',
        logoUrl: 'https://example.com/logo.png',
      );

      expect(themeDto.gradientPrimaryMain, '0xFF123456');
      expect(themeDto.gradientSecondaryMain, '0xFF654321');
      expect(themeDto.primary, '0xFF123456');
      expect(themeDto.secondary, '0xFF654321');
      expect(themeDto.text, '0xFFabcdef');
      expect(themeDto.background, '0xFFfedcba');
      expect(themeDto.logoUrl, 'https://example.com/logo.png');
    });

    test('fromJson creates an instance from JSON map', () {
      final json = {
        'gradient': {
          'primaryMain': '0xFF123456',
          'secondaryMain': '0xFF654321',
        },
        'primary': '0xFF123456',
        'secondary': '0xFF654321',
        'text': '0xFFabcdef',
        'background': '0xFFfedcba',
        'logo_url': 'https://example.com/logo.png',
      };

      final themeDto = ThemeDto.fromJson(json);

      expect(themeDto.gradientPrimaryMain, '0xFF123456');
      expect(themeDto.gradientSecondaryMain, '0xFF654321');
      expect(themeDto.primary, '0xFF123456');
      expect(themeDto.secondary, '0xFF654321');
      expect(themeDto.text, '0xFFabcdef');
      expect(themeDto.background, '0xFFfedcba');
      expect(themeDto.logoUrl, 'https://example.com/logo.png');
    });

    test('defaultTheme provides default values', () {
      final themeDto = ThemeDto.defaultTheme();

      expect(themeDto.gradientPrimaryMain, '0xFF000000');
      expect(themeDto.gradientSecondaryMain, '0xFF000000');
      expect(themeDto.primary, '0xFF000000');
      expect(themeDto.secondary, '0xFF000000');
      expect(themeDto.text, '0xFF000000');
      expect(themeDto.background, '0xFF000000');
      expect(themeDto.logoUrl, isEmpty);
    });
  });
}
