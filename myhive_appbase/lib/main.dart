import 'package:appcore/appcore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myhive_appbase/config/general_business_base_app.dart';
import 'build_config.dart';
import 'env.dart';
import 'l10n/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    AppCore(
      business: GeneralBusinessBaseApp.myhive,
      appConfig: BuildConfig(),
      apiIdOneSignal: appCoreConfigDto.apiIdOneSignal,
      textColorApp: authConfigDto.authTextColor,
      backgroundApp: appCoreConfigDto.background,
      themeMode: appCoreConfigDto.themeMode,
      urlBase: urlBase,
      localizations: AppLocalizations(),
      localizationDelegate: AppLocalizations.delegate,
    ).init(),
  );
}
