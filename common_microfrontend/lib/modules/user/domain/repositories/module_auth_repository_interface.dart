import 'package:common_microfrontend/modules/user/domain/entities/module_auth_drawer_entity.dart';
import 'package:common_microfrontend/modules/user/domain/entities/module_auth_home_entity.dart';

abstract class ModuleAuthRepositoryInterface {
  Future<List<ModuleAuthDrawerEntity>> getModuleAuthDrawer();
  Future<List<ModuleAuthHomeEntity>> getModuleAuthHome();
}
