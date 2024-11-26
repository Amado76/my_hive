import 'package:settings_microfrontend/app/data/repositories/settings_language_repository_impl.dart';
import 'package:settings_microfrontend/app/domain/interfaces/settings_language_repository_interface.dart';
import 'package:settings_microfrontend/app/presentation/bloc/settings_bloc.dart';
import 'package:settings_microfrontend/app/presentation/page/settings_page.dart';
import 'package:settings_microfrontend/l10n/translation_settings.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class SettingsModule extends Module {
  BindConfig<T> blocConfig<T extends Bloc>() {
    return BindConfig(
      notifier: (bloc) => bloc.stream,
      onDispose: (bloc) => bloc.close(),
    );
  }

  @override
  void binds(i) {
    Modular.get<Translation>().registerTranslations(
      TranslationSettings(),
    );

    i.addLazySingleton<SettingsLanguageRepositoryInterface>(
      () => SettingsLanguageRepositoryImpl(
        settingsDataSource: i<SecureLocalStorageInterface>(),
      ),
    );

    i.addLazySingleton<SettingsBloc>(
      () => SettingsBloc(
        repository: i<SettingsLanguageRepositoryInterface>(),
      ),
      config: blocConfig<SettingsBloc>(),
    );
  }

  @override
  void routes(r) {
    final NavigationInjector navigator = Modular.get<NavigationInjector>();
    navigator.setPaths(
      package: 'settings',
      pathList: {
        "root": "/",
      },
    );

    r.child(
      navigator.getPath(
        package: "settings",
        pathKey: "root",
      ),
      child: (_) => const SettingsPage(),
    );
  }
}
