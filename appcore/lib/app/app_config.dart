import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/material.dart' show Color;

abstract class AppConfig {
  void configure(
    RouteManager r,
    Color background,
    String themeMode,
    Color textColorApp,
  );
}
