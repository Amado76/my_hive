import 'package:flutter/material.dart';

class ThemeColorsExtension extends ThemeExtension<ThemeColorsExtension> {
  ThemeColorsExtension({
    required this.primaryColor,
    required this.secondaryColor,
  });

  final Color primaryColor;
  final Color secondaryColor;

  @override
  ThemeExtension<ThemeColorsExtension> copyWith({
    Color? primaryColor,
    Color? secondaryColor,
  }) {
    return ThemeColorsExtension(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }

  @override
  ThemeExtension<ThemeColorsExtension> lerp(
    covariant ThemeExtension<ThemeColorsExtension>? other,
    double t,
  ) {
    if (other is! ThemeColorsExtension) {
      return this;
    }

    return ThemeColorsExtension(
      primaryColor: Color.lerp(
        primaryColor,
        other.primaryColor,
        t,
      )!,
      secondaryColor: Color.lerp(
        secondaryColor,
        other.secondaryColor,
        t,
      )!,
    );
  }
}
