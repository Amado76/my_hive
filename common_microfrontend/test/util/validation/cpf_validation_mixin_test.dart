import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:common_microfrontend/util/validation/cpf_validation_mixin.dart';

class CpfValidationMixinMock with CpfValidationMixin {}

class GeneralConfigModular extends Module {
  @override
  List<Module> get imports => [
        CommonModule(),
      ];
}

void main() {
  final cpfValidationMixin = CpfValidationMixinMock();
  WidgetsFlutterBinding.ensureInitialized();

  Modular.bindModule(GeneralConfigModular());

  GeneralConfig gc = Modular.get<GeneralConfig>();
  gc.reset();
  gc.business = GeneralBusiness.education;
  gc.language = 'pt';

  final translation = Modular.get<Translation>();
  translation.reset(business: GeneralBusiness.education);

  translation.registerTranslations(
    CommonTranslation(),
  );

  group('[CPF Validation]', () {
    test('isValidCpf', () {
      expect(cpfValidationMixin.isValidCpf('12345678909'), null);
      expect(cpfValidationMixin.isValidCpf('12345678900'), 'CPF inválido');
    });
  });
}
