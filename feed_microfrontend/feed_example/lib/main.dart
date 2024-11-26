import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'build_config.dart';
import 'env.dart';
import 'l10n/generated/l10n.dart';
import 'package:appcore/appcore.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(AppSplashScreen(background: appCoreConfigDto.background));

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    AppCore(
      appConfig: BuildConfig(),
      backgroundApp: appCoreConfigDto.background,
      apiIdOneSignal: apiIdOneSignal,
      textColorApp: textColorApp,
      themeMode: themeMode,
      urlBase: urlBase,
      business: GeneralBusiness.education,
      localizations: AppLocalizations(),
      localizationDelegate: AppLocalizations.delegate,
    ).init(),
  );
}
