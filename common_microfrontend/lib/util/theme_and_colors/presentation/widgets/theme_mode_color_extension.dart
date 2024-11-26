import 'package:flutter/material.dart';
import 'package:common_microfrontend/util/theme_and_colors/domain/util/hex_color.dart';

class ThemeModeColorExtension extends ThemeExtension<ThemeModeColorExtension> {
  ThemeModeColorExtension({
    this.background = 'light',
    this.text = 'dark',
  });

  final String background;
  final String text;

  @override
  ThemeModeColorExtension copyWith({
    String? background,
    String? text,
  }) {
    return ThemeModeColorExtension(
      background: background ?? this.background,
      text: text ?? this.text,
    );
  }

  @override
  ThemeModeColorExtension lerp(
    covariant ThemeExtension<ThemeModeColorExtension>? other,
    double t,
  ) {
    if (other is! ThemeModeColorExtension) {
      return this;
    }

    return ThemeModeColorExtension(
      background: t < 0.5 ? background : other.background,
      text: t < 0.5 ? text : other.text,
    );
  }

  Color get backgroundColor {
    if (background == 'dark') {
      return Color(HexColor.intFromHex('#242424'));
    } else {
      return Colors.grey[50]!;
    }
  }

  Color get textColor {
    if (text == 'dark') {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  Color get cardColor {
    if (background == 'dark') {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }
}
