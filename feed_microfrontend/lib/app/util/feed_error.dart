import 'package:flutter/foundation.dart' show immutable;
import 'package:common_microfrontend/common_microfrontend.dart';

@immutable
sealed class FeedError extends Equatable {
  final String dialogTitle;
  final String dialogText;

  const FeedError({
    required this.dialogTitle,
    required this.dialogText,
  });

  factory FeedError.from(Exception exception) {
    return FeedUnknownError();
  }
}

@immutable
class FeedUnknownError extends FeedError {
  FeedUnknownError()
      : super(
            dialogTitle: Modular.get<Translation>()
                .translate(key: "unknownErrorTitle", package: "feed"),
            dialogText: Modular.get<Translation>()
                .translate(key: "unknownErrorText", package: "feed"));

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}
