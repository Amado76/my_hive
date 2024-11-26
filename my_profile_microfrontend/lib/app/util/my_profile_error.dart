import 'package:flutter/foundation.dart' show immutable;
import 'package:common_microfrontend/common_microfrontend.dart';

@immutable
sealed class MyProfileError extends Equatable {
  final String dialogTitle;
  final String dialogText;

  const MyProfileError({
    required this.dialogTitle,
    required this.dialogText,
  });

  factory MyProfileError.from(Exception exception) {
    return MyProfileUnknownError();
  }
}

@immutable
class MyProfileUnknownError extends MyProfileError {
  MyProfileUnknownError()
      : super(
            dialogTitle: Modular.get<Translation>()
                .translate(key: "unknownErrorTitle", package: "my_profile"),
            dialogText: Modular.get<Translation>()
                .translate(key: "unknownErrorText", package: "my_profile"));

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}
