import 'package:home_microfrontend/app/home/domain/entity/module_data_entity.dart';
import 'package:home_microfrontend/app/home/domain/module_data_strategy.dart';

class ModuleDataChainNode {
  final HomeModuleDataStrategy _homeModuleDataStrategy =
      HomeModuleDataStrategy();

  final CommunicationModuleDataStrategy _communicationModuleDataStrategy =
      CommunicationModuleDataStrategy();
  final MyProfileStrategy _myProfileStrategy = MyProfileStrategy();

  ModuleDataEntity? moduleData(String moduleName) {
    _homeModuleDataStrategy
        .setNextModuleDataStrategy(_communicationModuleDataStrategy);
    _communicationModuleDataStrategy
        .setNextModuleDataStrategy(_myProfileStrategy);

    return _homeModuleDataStrategy.moduleData(moduleName);
  }
}
