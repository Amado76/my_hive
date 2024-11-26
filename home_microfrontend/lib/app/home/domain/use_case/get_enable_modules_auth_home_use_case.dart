import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:common_microfrontend/modules/user/domain/entities/module_auth_home_entity.dart';

class GetEnableModulesAuthHomeUseCase {
  GetEnableModulesAuthHomeUseCase();
  final GeneralConfig generalConfig = Modular.get<GeneralConfig>();

  List<ModuleAuthHomeEntity> call() {
    final List<ModuleAuthHomeEntity> modulesList =
        generalConfig.userEntity!.modulesAuthHome;
    final List<ModuleAuthHomeEntity> enabledModules =
        _getEnabledModules(modulesList);
    final List<ModuleAuthHomeEntity> disponibleModules =
        _verifyCompletedModules(enabledModules, _completedModules);
    final List<ModuleAuthHomeEntity> orderedButtonsList =
        _verifyMinimumModules(disponibleModules);
    orderedButtonsList.sort((a, b) => a.order!.compareTo(b.order!));

    return orderedButtonsList;
  }

  List<ModuleAuthHomeEntity> _getEnabledModules(
      List<ModuleAuthHomeEntity> listModules) {
    return listModules.where((module) => module.isAuthorized!).toList();
  }

  List<ModuleAuthHomeEntity> _verifyMinimumModules(
      List<ModuleAuthHomeEntity> listModules) {
    final List<ModuleAuthHomeEntity> enabledModules =
        _getEnabledModules(listModules);

    if (enabledModules.length <= 5) {
      enabledModules.add(const ModuleAuthHomeEntity(
        appRoute: 'my_profile',
        order: 99998,
        id: 4,
        isAuthorized: true,
        name: 'my_profile',
        iconLib: '',
        iconName: '',
      ));
    }
    return enabledModules;
  }

  List<ModuleAuthHomeEntity> _verifyCompletedModules(
      List<ModuleAuthHomeEntity> enabledModules,
      List<String> completedModules) {
    List<ModuleAuthHomeEntity> disponibleModules = [];

    for (final module in enabledModules) {
      if (_completedModules.contains(module.appRoute)) {
        disponibleModules.add(module);
      }
    }
    return disponibleModules;
  }

  final List<String> _completedModules = [
    'Home',
    'PlayerCard',
    'Events',
    'Communication',
    'Activities',
    'Tips',
    'Modules',
    'Quiz',
    'Products',
    'WebTV',
    'WebSite',
    'Championships'
  ];
}
