import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_microfrontend/app/home/domain/entity/module_data_entity.dart';
import 'package:home_microfrontend/app/home/domain/module_data_chain_node.dart';
import 'package:home_microfrontend/l10n/translation_home.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class GeneralConfigModular extends Module {
  @override
  List<Module> get imports => [
        CommonModule(),
      ];
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Modular.bindModule(GeneralConfigModular());

  final GeneralConfig gc = Modular.get<GeneralConfig>();
  gc.reset();
  gc.business = GeneralBusiness.education;
  gc.language = WidgetsBinding.instance.platformDispatcher.locale.languageCode;

  Modular.get<Translation>().registerTranslations(
    TranslationHome(),
  );
  test('should return home', () {
    final ModuleDataChainNode moduleDataChainNode = ModuleDataChainNode();
    final ModuleDataEntity moduleDataEntity =
        moduleDataChainNode.moduleData('Home')!;
    expect(moduleDataEntity, isA<ModuleDataEntity>());
  });

  test('should return null', () {
    final ModuleDataChainNode moduleDataChainNode = ModuleDataChainNode();
    final ModuleDataEntity? moduleDataEntity =
        moduleDataChainNode.moduleData('null');
    expect(moduleDataEntity, isNull);
  });

  test('should return Communication', () {
    final ModuleDataChainNode moduleDataChainNode = ModuleDataChainNode();
    final ModuleDataEntity? moduleDataEntity =
        moduleDataChainNode.moduleData('Communication');
    expect(moduleDataEntity, isA<ModuleDataEntity>());
  });
}
