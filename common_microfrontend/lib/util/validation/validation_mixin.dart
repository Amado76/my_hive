import 'package:common_microfrontend/common_microfrontend.dart';

mixin ValidationMixin {
  final Translation _translation = Modular.get<Translation>();

  String? isNotNull(String? value, [String? message]) {
    if (value == null) {
      return message ??
          _translation.translate(
            package: "common",
            key: "validationRequiredField",
          );
    }

    return null;
  }

  String? isNotEmpty(String? value, [String? message]) {
    if (value?.isEmpty == true) {
      return message ??
          _translation.translate(
            package: "common",
            key: "validationRequiredField",
          );
    }

    return null;
  }

  String? hasMinLength(String? value, int minLength, [String? message]) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.length < minLength) {
      return message ??
          _translation.translate(
            package: "common",
            key: "validationMinLength",
            args: [minLength.toString()],
          );
    }

    return null;
  }

  String? hasMaxLength(String? value, int maxLength, [String? message]) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.length > maxLength) {
      return message ??
          _translation.translate(
            package: "common",
            key: "validationMaxLength",
            args: [maxLength.toString()],
          );
    }

    return null;
  }

  String? isEqualTo(String? value, String? compare, [String? message]) {
    if (value != compare) {
      return message ??
          _translation.translate(
            package: "common",
            key: "validationNotEqual",
          );
    }

    return null;
  }

  String? combine(List<String? Function()> validators) {
    for (final func in validators) {
      final validation = func();
      if (validation != null) return validation;
    }

    return null;
  }
}
