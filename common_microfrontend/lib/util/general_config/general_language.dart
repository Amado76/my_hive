import 'package:flutter/widgets.dart';

class GeneralLanguage {
  static String get systemLanguage {
    return WidgetsBinding.instance.platformDispatcher.locale.languageCode;
  }
}
