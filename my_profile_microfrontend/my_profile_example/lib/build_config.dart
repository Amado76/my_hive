import 'package:appcore/appcore.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/material.dart';
import 'package:my_profile_example/env.dart';
import 'package:my_profile_microfrontend/app/my_profile_module.dart';

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
        'myprofile': '/my_profile/',
      },
    );

    appCoreConfigDto.homeUrl = navigator.getPath(
      package: 'baseapp',
      pathKey: 'myprofile',
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
          pathKey: 'myprofile',
        ),
        module: MyProfileModule(isoCode: null));
  }
}
