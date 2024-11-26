import 'package:common_microfrontend/util/design_system/components/animated_drawer/domain/entities/drawer_item.dart';

abstract class DrawerItemRepositoryInterface {
  List<DrawerItem> getItensToDrawer();
}
