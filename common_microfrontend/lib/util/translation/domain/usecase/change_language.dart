import 'package:common_microfrontend/common_microfrontend.dart';

class ChangeLanguage {
  final TranslationBloc translationBloc = Modular.get<TranslationBloc>();

  Future<void> call(String language) async {
    translationBloc.changeLanguage(language: language);
  }
}
