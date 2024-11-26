import 'package:flutter/material.dart';

class GradienteColorsExtension
    extends ThemeExtension<GradienteColorsExtension> {
  GradienteColorsExtension({
    this.primaryColor,
    this.secondaryColor,
  });

  final Color? primaryColor;
  final Color? secondaryColor;

  @override
  ThemeExtension<GradienteColorsExtension> copyWith({
    Color? primaryColor,
    Color? secondaryColor,
  }) {
    return GradienteColorsExtension(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }

  @override
  ThemeExtension<GradienteColorsExtension> lerp(
    covariant ThemeExtension<GradienteColorsExtension>? other,
    double t,
  ) {
    if (other is! GradienteColorsExtension) {
      return this;
    }

    return GradienteColorsExtension(
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
