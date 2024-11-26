import 'package:appcore/appcore.dart';
import 'package:auth_microfrontend/package.dart';
import 'package:feed_microfrontend/app/feed_module.dart';
import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:home_microfrontend/app/home_module.dart';
import 'package:my_profile_microfrontend/app/my_profile_module.dart';
import 'package:myhive_appbase/env.dart';
import 'package:myhive_appbase/l10n/translation_base_app_personalization.dart';
import 'package:settings_microfrontend/app/settings_module.dart';

class BuildConfig implements AppConfig {
  @override
  void configure(
    RouteManager r,
    Color background,
    String themeMode,
    Color textColorApp,
  ) {
    final Translation translation = Modular.get<Translation>();
    translation.registerTranslations(
      TranslationBaseAppPersonalization(),
    );

    final NavigationInjector navigator = Modular.get<NavigationInjector>();
    navigator.setPaths(
      package: 'baseapp',
      pathList: {
        'root': '/',
        'authentication': '/authentication/',
        'home': '/home/',
        'changeprofile': '/change_profile/',
        'myprofile': '/my_profile/',
        'notification': '/notification/',
        'settings': '/settings/',
        'class_group': '/class_group/',
      },
    );
    r.child(
      navigator.getPath(
        package: 'baseapp',
        pathKey: 'root',
      ),
      child: (_) => AppPageRedirect(
        appCoreConfigDto: appCoreConfigDto,
      ),
    );

    r.module(
      navigator.getPath(
        package: 'baseapp',
        pathKey: 'authentication',
      ),
      module: AuthenticationModule(
        authConfigDto: authConfigDto,
        homeUrl: navigator.getPath(
          package: 'baseapp',
          pathKey: 'home',
        ),
      ),
    );

    r.module(
      navigator.getPath(
        package: 'baseapp',
        pathKey: 'home',
      ),
      module: HomeModule(),
    );

    r.module(
      navigator.getPath(
        package: 'baseapp',
        pathKey: 'settings',
      ),
      module: SettingsModule(),
    );

    r.module(
      navigator.getPath(
        package: 'baseapp',
        pathKey: 'myprofile',
      ),
      module: MyProfileModule(isoCode: authConfigDto.isoCode),
    );

    r.module(
      navigator.getPath(
        package: 'baseapp',
        pathKey: 'tips',
      ),
      module: FeedModule(),
    );
  }
}
