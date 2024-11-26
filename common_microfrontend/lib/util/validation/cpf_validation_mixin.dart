import 'package:common_microfrontend/common_microfrontend.dart';

mixin CpfValidationMixin {
  String? isValidCpf(String? value, [String? message]) {
    if (value == null || value.isEmpty) {
      return null;
    }

    value = _removeNonDigits(value);

    if (!_hasCorrectLength(value) ||
        _hasRepeatedDigits(value) ||
        !_hasValidCheckDigits(value)) {
      return message ??
          Modular.get<Translation>().translate(
            package: "common",
            key: "validationInvalidCpf",
          );
    }

    return null;
  }

  String _removeNonDigits(String value) {
    return value.replaceAll(RegExp(r'[^\d]'), '');
  }

  bool _hasCorrectLength(String value) {
    return value.length == 11;
  }

  bool _hasRepeatedDigits(String value) {
    return RegExp(r'^(\d)\1*$').hasMatch(value);
  }

  bool _hasValidCheckDigits(String value) {
    for (var i = 9; i < 11; i++) {
      int sum = 0;
      for (var j = 0; j < i; j++) {
        sum += int.parse(value[j]) * ((i + 1) - j);
      }
      int remainder = sum % 11;
      if (value[i] != ((remainder < 2) ? '0' : (11 - remainder).toString())) {
        return false;
      }
    }
    return true;
  }
}
