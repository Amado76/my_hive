import 'package:appcore/app/app_config.dart';
import 'package:appcore/app/app_module.dart';
import 'package:appcore/app/app_widget.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/material.dart';

class AppCore<TLocalizations, TLocalizationDelegate> {
  final Color backgroundApp;
  final String themeMode;
  final String urlBase;
  final Color textColorApp;
  final String apiIdOneSignal;
  final String? appTitle;
  final AppConfig appConfig;
  final String business;
  final String buildBusiness;
  final TLocalizations localizations;
  final TLocalizationDelegate localizationDelegate;

  AppCore({
    required this.appConfig,
    required this.backgroundApp,
    required this.apiIdOneSignal,
    required this.textColorApp,
    required this.themeMode,
    required this.urlBase,
    required this.business,
    this.buildBusiness = '',
    this.appTitle,
    required this.localizations,
    required this.localizationDelegate,
  });

  ModularApp init() {
    return ModularApp(
      module: AppModule(
        appConfig: appConfig,
        urlBase: urlBase,
        background: backgroundApp,
        apiIdOneSignal: apiIdOneSignal,
        textColorApp: textColorApp,
        themeMode: themeMode,
        business: business,
        buildBusiness: buildBusiness,
      ),
      child: AppWidget<TLocalizations, TLocalizationDelegate>(
        background: backgroundApp,
        localizationDelegate: localizationDelegate,
        localizations: localizations,
        appTitle: appTitle ?? '',
      ),
    );
  }
}
