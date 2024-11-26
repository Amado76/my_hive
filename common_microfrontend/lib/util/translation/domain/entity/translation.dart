import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/widgets.dart';

class Translation {
  final Map<String, Map<String, String>> _translations = {};
  String? _business;
  String? _buildBusiness;

  String _generateKey(String language, String business, String package) {
    return '$language-$business-$package';
  }

  void registerTranslations(
    TranslationObject translationObject,
  ) {
    _business = Modular.get<GeneralConfig>().business;
    _buildBusiness = Modular.get<GeneralConfig>().buildBusiness;

    var objects = TranslationObject.fromJsonData(translationObject.jsonData);
    for (var obj in objects) {
      if (obj is TranslationObjectImpl) {
        String key = _generateKey(obj.language, obj.business, obj.package);
        _translations[key] = obj.translations;
      }
    }
  }

  String translate({
    required String package,
    required String key,
    List<String> args = const [],
  }) {
    // uso o método aberto pra test que permite enviar o idioma como parâmetro
    // mas aberto ao uso geral não permite isso, apenas para testes
    return translatetest(
      language: Modular.get<GeneralConfig>().language!,
      package: package,
      key: key,
      args: args,
    );
  }

  String showDate({
    required String yearString,
    required String monthString,
    required String dayString,
  }) {
    int year = int.parse(yearString);
    int month = int.parse(monthString);
    int day = int.parse(dayString);

    DateTime date = DateTime(year, month, day);

    return showObjectDate(date);
  }

  String showObjectDate(DateTime date) {
    return DateFormat.yMd().format(date);
  }

  String showMoney(double amount) {
    return NumberFormat.simpleCurrency().format(amount);
  }

  @visibleForTesting
  void reset({
    required String business,
    String builBusiness = '',
  }) {
    _translations.clear();
    _business = business;
    _buildBusiness = builBusiness;
  }

  String? _getTranslation(
    String package,
    String language,
    String key,
    String business,
  ) {
    return _translations[_generateKey(
      language,
      business,
      package,
    )]?[key];
  }

  @visibleForTesting
  String translatetest({
    required String language,
    required String package,
    required String key,
    List<String> args = const [],
  }) {
    String translate =
        _getTranslation(package, language, key, _buildBusiness!) ??
            _getTranslation(package, language, key, _business!) ??
            _getTranslation(package, language, key, GeneralBusiness.general) ??
            'Translation not found';

    for (int i = 0; i < args.length; i++) {
      translate = translate.replaceAll('{$i}', args[i]);
    }

    return translate;
  }
}
