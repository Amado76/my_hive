import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/util/theme_and_colors/data/theme_dto.dart';
import 'package:common_microfrontend/util/theme_and_colors/presentation/widgets/theme_data_factory.dart';

void main() {
  group('ThemeDataFactory', () {
    test('creates ThemeData correctly based on ThemeDto', () {
      WidgetsFlutterBinding.ensureInitialized();

      final themeDto = ThemeDto(
        primary: '0xFF123456',
        secondary: '0xFF654321',
        text: '0xFFabcdef',
        background: '0xFFfedcba',
        logoUrl: 'https://example.com/logo.png',
        gradientPrimaryMain: '0xFFFFFFFF',
        gradientSecondaryMain: '0xFF000000',
      );

      final themeData = ThemeDataFactory.createThemeData(themeDto);

      expect(themeData.appBarTheme.backgroundColor, const Color(0xFF123456));
      expect(themeData.colorScheme.primary, const Color(0xFF123456));
      expect(themeData.colorScheme.secondary, const Color(0xFF654321));
      expect(themeData.colorScheme.brightness, Brightness.light);
      expect(themeData.appBarTheme.titleTextStyle?.color, Colors.white);
      expect(
        themeData.appBarTheme.titleTextStyle?.fontFamily,
        'Rajdhani_regular',
      );
      expect(themeData.appBarTheme.titleTextStyle?.fontSize, 24);
    });
  });
}
