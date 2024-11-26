import 'package:appcore/app/app_config.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/material.dart';
import 'package:settings_microfrontend/app/data/repositories/settings_language_repository_impl.dart';
import 'package:settings_microfrontend/app/domain/interfaces/settings_language_repository_interface.dart';
import 'package:settings_microfrontend/app/domain/use_case/get_settings_language.dart';

class AppModule extends Module {
  final Color background;
  final String themeMode;
  final String urlBase;
  final AppConfig appConfig;
  Color textColorApp;
  String apiIdOneSignal;
  String business;
  String buildBusiness;

  AppModule({
    required this.appConfig,
    required this.background,
    required this.urlBase,
    required this.apiIdOneSignal,
    required this.textColorApp,
    this.themeMode = 'light',
    this.business = '',
    this.buildBusiness = '',
  }) {
    if (business.isEmpty) {
      business = GeneralBusiness.general;
    }
  }
  @override
  List<Module> get imports => [
        CommonModule(),
      ];

  @override
  void binds(Injector i) {
    i.addSingleton<SettingsLanguageRepositoryInterface>(
      () => SettingsLanguageRepositoryImpl(
        settingsDataSource: i<SecureLocalStorageInterface>(),
      ),
    );
    i.addSingleton<GetSettingsLanguageUseCase>(
      () => GetSettingsLanguageUseCase(
        i<SettingsLanguageRepositoryInterface>(),
      ),
    );
  }

  @override
  void routes(r) {
    final GeneralConfig gc = Modular.get<GeneralConfig>();
    gc.business = business;
    gc.buildBusiness = buildBusiness;

    final UrlInjector urlInjector = Modular.get<UrlInjector>();
    urlInjector.setBaseUrl(url: urlBase);

    Modular.get<Translation>().registerTranslations(
      CommonTranslation(),
    );

    appConfig.configure(
      r,
      background,
      themeMode,
      textColorApp,
    );
  }
}
