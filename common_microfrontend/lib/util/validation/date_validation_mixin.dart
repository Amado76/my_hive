import 'package:common_microfrontend/common_microfrontend.dart';

mixin DateValidationMixin {
  String? isValidDate(String? value, [String? message]) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (!_hasCorrectFormat(value)) {
      return message ??
          Modular.get<Translation>().translate(
            package: "common",
            key: "validationInvalidDate",
          );
    }

    return null;
  }

  bool _hasCorrectFormat(String value) {
    return RegExp(r'^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/[0-9]{4}$')
        .hasMatch(value);
  }
}
