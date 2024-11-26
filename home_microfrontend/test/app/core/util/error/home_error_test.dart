import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_microfrontend/app/core/util/error/home_error.dart';
import 'package:home_microfrontend/l10n/translation_home.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

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
  test('support value comparison', () {
    expect(HomeUserNotFound(), HomeUserNotFound());
  });

  test('support value comparison', () {
    expect(HomeUserNotFound(), HomeUserNotFound());
  });

  test('support value comparison', () {
    expect(HomeErrorTermsOfUseNotDefined(), HomeErrorTermsOfUseNotDefined());
  });

  test('support value comparison', () {
    expect(HomeUserNotFound(), HomeUserNotFound());
  });

  test(
      'should return a HomeErrorUnknow when the exception is a PlataformException',
      () {
    final exception = PlatformException(code: 'error');
    final result = HomeError.from(exception);
    expect(result, HomeErrorUnknown());
  });

  test(
      'should return a HomeErrorUnknow when the exception is a CustomConnectionException',
      () {
    final exception = CustomConnectionException(
        message: 'error', requestOptions: RequestOptions(path: ''));
    final result = HomeError.from(exception);
    expect(result, HomeErrorUnknown());
  });

  test('should return a HomeErrorUnknow when the exception is a Exception', () {
    final exception = Exception(
      'error',
    );
    final result = HomeError.from(exception);
    expect(result, HomeErrorUnknown());
  });
  test('should return a HomeErrorUnknow when the exception is a GTecException',
      () {
    final exception = GTecException(
      message: 'error',
    );
    final result = HomeError.from(exception);
    expect(result, HomeErrorUnknown());
  });
}

class GeneralConfigModular extends Module {
  @override
  List<Module> get imports => [
        CommonModule(),
      ];
}
