import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:common_microfrontend/util/validation/cpf_validation_mixin.dart';
import 'package:common_microfrontend/util/validation/validation_mixin.dart';

class ValidationMixinMock with ValidationMixin {}

class MultipleValidationMixinMock with ValidationMixin, CpfValidationMixin {}

class GeneralConfigModular extends Module {
  @override
  List<Module> get imports => [
        CommonModule(),
      ];
}

void main() {
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

  final validationMixin = ValidationMixinMock();
  final multipleValidationMixin = MultipleValidationMixinMock();

  group('[Validation Mixin]', () {
    test('should validate if something is not null', () {
      expect(validationMixin.isNotNull(null), 'Este campo é obrigatório');
      expect(validationMixin.isNotNull(null, 'Mensagem Personalizada'),
          'Mensagem Personalizada');
      expect(validationMixin.isNotNull('Algo que não é null'), null);
    });

    test('should validate if a string is not empty', () {
      expect(validationMixin.isNotEmpty(''), 'Este campo é obrigatório');
      expect(validationMixin.isNotEmpty('', 'Mensagem Personalizada'),
          'Mensagem Personalizada');
      expect(validationMixin.isNotEmpty('Algo que não é vazio'), null);
    });

    test('should validate if a string has a minimum length', () {
      expect(validationMixin.hasMinLength('123', 4),
          'Este campo deve ter no mínimo 4 caracteres');
      expect(validationMixin.hasMinLength('123', 4, 'Mensagem Personalizada'),
          'Mensagem Personalizada');
      expect(validationMixin.hasMinLength('1234', 4), null);
    });

    test('should validate if a string has a maximum length', () {
      expect(validationMixin.hasMaxLength('12345', 4),
          'Este campo deve ter no máximo 4 caracteres');
      expect(validationMixin.hasMaxLength('12345', 4, 'Mensagem Personalizada'),
          'Mensagem Personalizada');
      expect(validationMixin.hasMaxLength('1234', 4), null);
    });

    test('should validate if a string is equal to another', () {
      expect(validationMixin.isEqualTo('123', '1234'),
          'Este campo deve ser igual ao outro campo.');
      expect(validationMixin.isEqualTo('123', '1234', 'Mensagem Personalizada'),
          'Mensagem Personalizada');
      expect(validationMixin.isEqualTo('123', '123'), null);
    });

    test('should combine multiple validators', () {
      expect(
          validationMixin.combine([
            () => validationMixin.isNotNull(null, 'Campo obrigatório'),
            () => validationMixin.isNotEmpty('', 'Campo obrigatório'),
          ]),
          'Campo obrigatório');

      expect(
          validationMixin.combine([
            () => validationMixin.isNotNull('Test', 'Campo obrigatório'),
            () => validationMixin.isNotEmpty('Test', 'Campo obrigatório'),
          ]),
          null);
    });

    test('should combine multiple validators including other mixins', () {
      expect(
          validationMixin.combine([
            () => validationMixin.isNotNull('Algo que não é nulo'),
            () => validationMixin.isNotEmpty('String que não está vazia'),
            () => multipleValidationMixin.isValidCpf('11242424'),
          ]),
          'CPF inválido');
    });

    test(
        'should combine multiple validators including other mixins and use custom messages',
        () {
      expect(
          validationMixin.combine([
            () => validationMixin.isNotNull('Algo que não é nulo'),
            () => validationMixin.isNotEmpty('String que não está vazia'),
            () => multipleValidationMixin.isValidCpf(
                '11242424', 'Mensagem Customizada de CPF'),
          ]),
          'Mensagem Customizada de CPF');
    });
  });
}
