import 'package:appcore/appcore.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'build_config.dart';
import 'env.dart';
import 'l10n/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(AppSplashScreen(background: appCoreConfigDto.background));

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    AppCore(
      business: GeneralBusiness.education,
      appConfig: BuildConfig(),
      backgroundApp: appCoreConfigDto.background,
      themeMode: themeMode,
      textColorApp: textColorApp,
      apiIdOneSignal: apiIdOneSignal,
      urlBase: urlBase,
      localizations: AppLocalizations(),
      localizationDelegate: AppLocalizations.delegate,
    ).init(),
  );
}
