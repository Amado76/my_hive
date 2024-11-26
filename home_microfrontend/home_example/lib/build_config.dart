import 'package:appcore/appcore.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/material.dart';
import 'package:home_example/env.dart';
import 'package:home_microfrontend/app/home_module.dart';

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
        'home': '/home/',
      },
    );

    appCoreConfigDto.homeUrl = navigator.getPath(
      package: 'baseapp',
      pathKey: 'home',
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
          pathKey: 'home',
        ),
        module: HomeModule());
  }
}
