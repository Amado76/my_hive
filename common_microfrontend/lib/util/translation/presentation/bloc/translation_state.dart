part of 'translation_bloc.dart';

@immutable
sealed class TranslationState {
  final String language;

  const TranslationState({required this.language});
}

final class TranslationInitialState extends TranslationState {
  const TranslationInitialState({required super.language});
}

final class TranslationBuildState extends TranslationState {
  const TranslationBuildState({required super.language});
}
