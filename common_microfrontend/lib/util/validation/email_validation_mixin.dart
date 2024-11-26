import 'package:common_microfrontend/common_microfrontend.dart';

mixin EmailValidationMixin {
  String? isValidEmail(String? value, [String? message]) {
    if (value != null && !_hasValidFormat(value)) {
      return message ??
          Modular.get<Translation>().translate(
            package: "common",
            key: "validationInvalidEmail",
          );
    }

    return null;
  }

  bool _hasValidFormat(String value) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
  }
}
