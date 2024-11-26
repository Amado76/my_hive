import 'package:home_microfrontend/app/home/domain/entity/module_data_entity.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

sealed class ModuleDataStrategy {
  ModuleDataStrategy? _nextDataStrategy;

  ModuleDataEntity? moduleData(String moduleName) => null;

  void setNextModuleDataStrategy(ModuleDataStrategy nextModuleDataStategy) =>
      _nextDataStrategy = nextModuleDataStategy;

  ModuleDataStrategy? get nextModuleDataStategy => _nextDataStrategy;
}

class HomeModuleDataStrategy extends ModuleDataStrategy {
  @override
  ModuleDataEntity? moduleData(String moduleName) {
    if (moduleName.trim().toLowerCase().toLowerCase() == 'home') {
      return ModuleDataEntity(
        package: 'baseapp',
        pathKey: 'home',
        moduleName:
            Modular.get<Translation>().translate(key: "home", package: "home"),
      );
    }
    return nextModuleDataStategy?.moduleData(moduleName);
  }
}

class CommunicationModuleDataStrategy extends ModuleDataStrategy {
  @override
  ModuleDataEntity? moduleData(String moduleName) {
    if (moduleName.trim().toLowerCase() == 'communication') {
      return ModuleDataEntity(
        package: 'baseapp',
        pathKey: 'notification',
        pathIcon: 'assets/icons/communication.png',
        moduleName: Modular.get<Translation>()
            .translate(key: "communication", package: "home"),
      );
    }
    return nextModuleDataStategy?.moduleData(moduleName);
  }
}

class MyProfileStrategy extends ModuleDataStrategy {
  @override
  ModuleDataEntity? moduleData(String moduleName) {
    if (moduleName.trim().toLowerCase() == 'my_profile') {
      return ModuleDataEntity(
        package: 'baseapp',
        pathKey: 'myprofile',
        pathIcon: 'assets/icons/person.png',
        moduleName: Modular.get<Translation>()
            .translate(key: "myProfile", package: "home"),
      );
    }
    return nextModuleDataStategy?.moduleData(moduleName);
  }
}
