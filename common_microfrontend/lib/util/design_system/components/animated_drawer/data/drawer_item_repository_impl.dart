import 'package:common_microfrontend/modules/user/domain/entities/module_auth_drawer_entity.dart';

import 'package:common_microfrontend/util/design_system/components/animated_drawer/domain/interfaces/drawer_item_repository_interface.dart';
import 'package:common_microfrontend/util/general_config/general_config.dart';
import 'package:common_microfrontend/util/translation/domain/entity/translation.dart';

import '../domain/entities/drawer_item.dart';
import '../util/drawer_itens_mapper.dart';

class DrawerItemRepositoryImpl extends DrawerItemRepositoryInterface {
  final GeneralConfig gc;
  final Translation translation;

  DrawerItemRepositoryImpl({
    required this.gc,
    required this.translation,
  });

  @override
  List<DrawerItem> getItensToDrawer() {
    final DrawerItensMapper dIM = DrawerItensMapper();

    final List<ModuleAuthDrawerEntity> listDrawerFromBack =
        gc.userEntity!.modulesAuthDrawer;

    final List<DrawerItem> drawer = listDrawerFromBack
        .map(
          (entity) => DrawerItem(
            translation.translate(
              package: 'common',
              key: entity.name!,
            ),
            dIM.getIconData(
              entity.iconLib!,
              entity.iconName!,
            ),
            dIM.getPath(
              entity.appRoute!,
            ),
          ),
        )
        .toList();

    return drawer;
  }
}
