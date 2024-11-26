import 'package:appcore/appcore.dart';
import 'package:auth_example/env.dart';
import 'package:auth_microfrontend/app/authentication_module.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/material.dart';

import 'example_home_page.dart';

class BuildConfig implements AppConfig {
  @override
  void configure(
    RouteManager r,
    Color background,
    String themeMode,
    Color textColorApp,
  ) {
    final NavigationInjector navigator = Modular.get<NavigationInjector>();
    navigator.setPaths(
      package: 'baseapp',
      pathList: {
        'root': '/',
        'authentication': '/authentication/',
        'home': '/home/',
      },
    );

    appCoreConfigDto.homeUrl = navigator.getPath(
      package: 'baseapp',
      pathKey: 'authentication',
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
        homeUrl: navigator.getPath(
          package: 'baseapp',
          pathKey: 'home',
        ),
        authConfigDto: authConfigDto,
      ),
    );

    r.child(
      navigator.getPath(
        package: "baseapp",
        pathKey: "home",
      ),
      child: (_) => const ExampleHomePage(),
    );
  }
}
