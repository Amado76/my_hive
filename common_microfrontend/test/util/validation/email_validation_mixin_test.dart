import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:common_microfrontend/util/validation/email_validation_mixin.dart';

class EmailValidationMixinMock with EmailValidationMixin {}

class GeneralConfigModular extends Module {
  @override
  List<Module> get imports => [
        CommonModule(),
      ];
}

void main() {
  final emailValidationMixin = EmailValidationMixinMock();
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
    test('isEmailValid when email is valid', () {
      expect(emailValidationMixin.isValidEmail('teste@gmail.com'), null);
      expect(emailValidationMixin.isValidEmail('teste@gmail.com.br'), null);
      expect(emailValidationMixin.isValidEmail('teste@gmail.com.edu.br'), null);
      expect(emailValidationMixin.isValidEmail('teste_teste@gmail.com'), null);
      expect(emailValidationMixin.isValidEmail('teste-teste@gmail.com'), null);
      expect(emailValidationMixin.isValidEmail('TESTE@gmail.com'), null);
      expect(emailValidationMixin.isValidEmail('TESTE@gmail.app.br'), null);
    });
    test('return null when the email is invalid', () {
      expect(emailValidationMixin.isValidEmail('teste'), 'E-mail inválido');
      expect(
          emailValidationMixin.isValidEmail('teste@teste'), 'E-mail inválido');
      expect(emailValidationMixin.isValidEmail('@teste'), 'E-mail inválido');
      expect(emailValidationMixin.isValidEmail('teste@'), 'E-mail inválido');
      expect(
          emailValidationMixin.isValidEmail('teste@teste.'), 'E-mail inválido');
      expect(emailValidationMixin.isValidEmail('teste@teste.c'),
          'E-mail inválido');
      expect(emailValidationMixin.isValidEmail('teste@teste.c.'),
          'E-mail inválido');
      expect(emailValidationMixin.isValidEmail('teste@teste.c.c'),
          'E-mail inválido');
      expect(emailValidationMixin.isValidEmail('teste@@teste.com'),
          'E-mail inválido');
    });
  });
}
