part of 'translation_bloc.dart';

@immutable
sealed class TranslationEvent {}

final class TranslationChangeLanguageEvent extends TranslationEvent {
  final String language;

  TranslationChangeLanguageEvent({required this.language});
}
