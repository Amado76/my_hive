import 'package:common_microfrontend/common_microfrontend.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:settings_microfrontend/app/domain/use_case/get_settings_language.dart';

class AppWidget<TLocalizations, TLocalizationDelegate> extends StatefulWidget {
  final Color background;
  final String appTitle;
  final TLocalizationDelegate localizationDelegate;
  final TLocalizations localizations;
  const AppWidget({
    super.key,
    required this.background,
    required this.appTitle,
    required this.localizationDelegate,
    required this.localizations,
  });

  @override
  State<AppWidget> createState() =>
      _AppWidgetState<TLocalizations, TLocalizationDelegate>();
}

class _AppWidgetState<TLocalizations, TLocalizationDelegate>
    extends State<AppWidget<TLocalizations, TLocalizationDelegate>> {
  final ThemeAndColorsBloc themeAndColorsBloc =
      Modular.get<ThemeAndColorsBloc>();
  final TranslationBloc translationBloc = Modular.get<TranslationBloc>();
  final GetSettingsLanguageUseCase getSettingsLanguageUseCase =
      Modular.get<GetSettingsLanguageUseCase>();
  final GeneralConfig gc = Modular.get<GeneralConfig>();

  @override
  void initState() {
    _asyncMethod();
    super.initState();
  }

  Future<void> _asyncMethod() async {
    gc.language = await getSettingsLanguageUseCase();
  }

  @override
  Widget build(BuildContext context) {
    // MaterialApp envolvido em um BlocBuilder para controlar o tema e as cores
    return BlocBuilder<TranslationBloc, TranslationState>(
      bloc: translationBloc,
      builder: (context, stateTranslation) {
        return BlocBuilder<ThemeAndColorsBloc, ThemeAndColorsState>(
          bloc: themeAndColorsBloc,
          builder: (context, stateTheme) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: widget.appTitle,
              themeMode: stateTheme.themeMode,
              theme: stateTheme.themeData,
              routerConfig: Modular.routerConfig,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                widget.localizationDelegate as LocalizationsDelegate<dynamic>,
              ],
              locale: Locale(stateTranslation.language),
              supportedLocales:
                  (widget.localizationDelegate as dynamic).supportedLocales,
            );
          },
        );
      },
    );
  }
}
