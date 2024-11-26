import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:common_microfrontend/util/validation/date_validation_mixin.dart';

class DateValidationMixinMock with DateValidationMixin {}

class GeneralConfigModular extends Module {
  @override
  List<Module> get imports => [
        CommonModule(),
      ];
}

void main() {
  final dateValidationMixin = DateValidationMixinMock();
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

  group('[Date Validation]', () {
    test('isValidDate when email is valid', () {
      expect(dateValidationMixin.isValidDate('11/01/1993'), null);
      expect(dateValidationMixin.isValidDate('31/01/2003'), null);
      expect(dateValidationMixin.isValidDate('21/12/2015'), null);
    });
    test('return error when the date is invalid', () {
      expect(dateValidationMixin.isValidDate('teste'), 'Data inválida');
      expect(dateValidationMixin.isValidDate('32/01/1993'), 'Data inválida');
      expect(dateValidationMixin.isValidDate('31/13/1993'), 'Data inválida');
      expect(dateValidationMixin.isValidDate('31/12/193'), 'Data inválida');
    });
  });
}
