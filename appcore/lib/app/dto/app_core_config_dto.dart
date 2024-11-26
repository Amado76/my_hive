import 'package:flutter/material.dart' show Color;

class AppCoreConfigDto {
  final Color background;
  final String apiIdOneSignal, themeMode;
  String? tokenToExample, homeUrl;
  dynamic args;

  AppCoreConfigDto(
      {required this.background,
      required this.apiIdOneSignal,
      this.tokenToExample,
      this.homeUrl,
      this.themeMode = 'light',
      this.args});
}
