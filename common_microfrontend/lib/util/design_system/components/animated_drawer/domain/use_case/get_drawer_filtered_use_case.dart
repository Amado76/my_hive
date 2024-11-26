import 'package:common_microfrontend/util/general_config/general_config.dart';
import 'package:common_microfrontend/util/navigation_injector/navigation_injector.dart';
import 'package:common_microfrontend/util/translation/domain/entity/translation.dart';
import 'package:flutter/material.dart';

import 'package:common_microfrontend/util/design_system/components/animated_drawer/domain/entities/drawer_item.dart';
import 'package:common_microfrontend/util/design_system/components/animated_drawer/domain/interfaces/drawer_item_repository_interface.dart';

class GetDrawerFilteredUseCase {
  final DrawerItemRepositoryInterface _drawerRepository;
  final NavigationInjector _navigator;
  final Translation _translation;

  GetDrawerFilteredUseCase({
    required DrawerItemRepositoryInterface drawerRepository,
    required GeneralConfig generalConfig,
    required NavigationInjector navigator,
    required Translation translation,
  })  : _drawerRepository = drawerRepository,
        _translation = translation,
        _navigator = navigator;

  List<DrawerItem> call() {
    List<DrawerItem> listDrawer = _drawerRepository.getItensToDrawer();

    listDrawer.add(DrawerItem(
      _translation.translate(
        package: 'common',
        key: 'my_profile',
      ),
      Icons.person,
      _navigator.getPath(
        package: 'baseapp',
        pathKey: 'myprofile',
      ),
    ));

    return listDrawer;
  }
}
