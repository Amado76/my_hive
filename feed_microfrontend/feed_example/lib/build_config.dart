import 'package:appcore/appcore.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:feed_example/env.dart';
import 'package:feed_microfrontend/app/feed_module.dart';
import 'package:flutter/material.dart';

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
        'tips': '/tips/',
      },
    );

    appCoreConfigDto.homeUrl = navigator.getPath(
      package: 'baseapp',
      pathKey: 'tips',
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
          pathKey: 'tips',
        ),
        module: FeedModule());
  }
}
