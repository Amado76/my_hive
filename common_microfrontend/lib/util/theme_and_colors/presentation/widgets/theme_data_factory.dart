import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/material.dart';
import 'package:common_microfrontend/util/theme_and_colors/data/theme_dto.dart';
import 'package:common_microfrontend/util/theme_and_colors/domain/util/hex_color.dart';
import 'package:common_microfrontend/util/theme_and_colors/presentation/widgets/theme_colors_extension.dart';
import 'package:common_microfrontend/util/theme_and_colors/presentation/widgets/theme_mode_color_extension.dart';

class ThemeDataFactory {
  static ThemeData createThemeData(ThemeDto theme) {
    final Color colorPrimary = Color(HexColor.intFromHex(theme.primary));
    final Color colorSecondary = Color(HexColor.intFromHex(theme.secondary));
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: theme.background == 'dark' ? Colors.white : Colors.black,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[350]!, width: 1.0),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[350]!, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        errorStyle:
            const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: theme.background == 'dark' ? Colors.black : Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: theme.background == 'dark'
              ? WidgetStateProperty.all<Color>(Colors.white)
              : WidgetStateProperty.all<Color>(Colors.black),
        ),
      ),
      iconTheme: IconThemeData(
        color: theme.text == 'dark' ? Colors.black : Colors.white,
      ),
      cardTheme: CardTheme(
        color: theme.background == 'dark' ? Colors.black : Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorPrimary,
        titleTextStyle: TextStyle(
          color: theme.text == 'dark' ? Colors.black : Colors.white,
          fontFamily: GoogleFonts.rajdhani().fontFamily,
          fontSize: 24,
        ),
      ),
      colorScheme: ColorScheme(
        brightness:
            theme.background == 'dark' ? Brightness.dark : Brightness.light,
        primary: colorPrimary,
        onPrimary: _getContrastingTextColor(
          colorPrimary,
        ),
        secondary: colorSecondary,
        onSecondary: _getContrastingTextColor(
          colorSecondary,
        ),
        error: Colors.red,
        onError: Colors.white,
        surface: theme.background == 'dark'
            ? Color(HexColor.intFromHex('#242424'))
            : Colors.grey[50]!,
        onSurface: theme.background == 'dark' ? Colors.white : Colors.black,
      ),
      extensions: [
        GradienteColorsExtension(
          primaryColor: Color(
            HexColor.intFromHex(
              theme.gradientPrimaryMain,
            ),
          ),
          secondaryColor: Color(
            HexColor.intFromHex(
              theme.gradientSecondaryMain,
            ),
          ),
        ),
        ThemeModeColorExtension(
          background: theme.background,
          text: theme.text,
        ),
        ThemeColorsExtension(
          primaryColor: colorPrimary,
          secondaryColor: colorSecondary,
        ),
      ],
    );
  }

  static Color _getContrastingTextColor(Color inputColor) {
    // Calcula a luminância relativa
    double luminance = (0.299 * inputColor.red +
            0.587 * inputColor.green +
            0.114 * inputColor.blue) /
        255;

    // Escolhe preto ou branco com base na luminância
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
