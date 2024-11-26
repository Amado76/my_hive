import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/foundation.dart';

part 'translation_event.dart';
part 'translation_state.dart';

class TranslationBloc extends Bloc<TranslationEvent, TranslationState> {
  TranslationBloc()
      : super(const TranslationInitialState(
          language: 'pt',
        )) {
    on<TranslationChangeLanguageEvent>((event, emit) {
      emit(TranslationBuildState(
        language: event.language,
      ));
    });
  }

  void changeLanguage({required String language}) {
    Modular.get<GeneralConfig>().language = language;
    add(TranslationChangeLanguageEvent(language: language));
  }
}
