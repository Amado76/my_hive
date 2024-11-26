import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'translation_mock.dart';

void main() {
  group('[Translation Tests]', () {
    test('should register translation and get portuguese', () async {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterSecureStorage.setMockInitialValues({});

      Modular.bindModule(GeneralConfigModular());

      GeneralConfig gc = Modular.get<GeneralConfig>();
      gc.reset();
      gc.business = GeneralBusiness.education;
      gc.language = 'pt';

      final translation = Modular.get<Translation>();
      translation.reset(business: GeneralBusiness.education);

      translation.registerTranslations(
        TranslationMock(),
      );

      expect(
        translation.translatetest(
          language: 'pt',
          package: 'login',
          key: 'boatarde',
        ),
        equals('Boa tarde aluno'),
      );
    });
    test('should register translation and get english', () async {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterSecureStorage.setMockInitialValues({});

      Modular.bindModule(GeneralConfigModular());

      GeneralConfig gc = Modular.get<GeneralConfig>();
      gc.reset();
      gc.business = GeneralBusiness.education;
      gc.language = 'en';

      final translation = Modular.get<Translation>();
      translation.reset(business: GeneralBusiness.education);

      translation.registerTranslations(TranslationMock());

      expect(
        translation.translate(
          package: 'login',
          key: 'boatarde',
        ),
        equals('good afternoon soccer'),
      );
    });
    test('should register translation and get english with args', () async {
      WidgetsFlutterBinding.ensureInitialized();

      Modular.bindModule(GeneralConfigModular());

      GeneralConfig gc = Modular.get<GeneralConfig>();
      gc.reset();
      gc.business = GeneralBusiness.education;
      gc.language = 'en';

      final translation = Modular.get<Translation>();
      translation.reset(business: GeneralBusiness.education);

      translation.registerTranslations(
        TranslationMock(),
      );

      expect(
        translation.translate(
          package: 'login',
          key: 'withargs',
          args: ['Ricardo', 'Pinto'],
        ),
        equals('good afternoon soccer Ricardo, Pinto'),
      );
    });
    test('should return date in english format', () async {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterSecureStorage.setMockInitialValues({});

      Modular.bindModule(GeneralConfigModular());

      GeneralConfig gc = Modular.get<GeneralConfig>();
      gc.reset();
      gc.business = GeneralBusiness.education;
      gc.language = 'en';

      final translation = Modular.get<Translation>();
      translation.reset(business: GeneralBusiness.education);

      expect(
        translation.showDate(
          yearString: '2021',
          monthString: '10',
          dayString: '31',
        ),
        equals('10/31/2021'),
      );
    });
    test('should return currency in english format', () async {
      WidgetsFlutterBinding.ensureInitialized();
      Modular.bindModule(GeneralConfigModular());

      GeneralConfig gc = Modular.get<GeneralConfig>();
      gc.reset();
      gc.business = GeneralBusiness.education;
      gc.language = 'en';

      final translation = Modular.get<Translation>();
      translation.reset(business: GeneralBusiness.education);

      expect(
        translation.showMoney(1234.56),
        equals('\$1,234.56'),
      );
    });
  });
  test('should register translation and get general pt and en', () async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterSecureStorage.setMockInitialValues({});

    Modular.bindModule(GeneralConfigModular());

    GeneralConfig gc = Modular.get<GeneralConfig>();
    gc.reset();
    gc.business = GeneralBusiness.education;
    gc.language = 'pt';

    final translation = Modular.get<Translation>();
    translation.reset(business: GeneralBusiness.education);

    translation.registerTranslations(
      TranslationMock(),
    );

    expect(
      translation.translatetest(
        language: 'pt',
        package: 'login',
        key: 'generaltranslate',
      ),
      equals('Esta tradução é apenas para negócios não encontrados'),
    );
    expect(
      translation.translatetest(
        language: 'en',
        package: 'login',
        key: 'generaltranslate2',
      ),
      equals('This translate are only for not found business2'),
    );
  });
}

class GeneralConfigModular extends Module {
  @override
  List<Module> get imports => [
        CommonModule(),
      ];
}
