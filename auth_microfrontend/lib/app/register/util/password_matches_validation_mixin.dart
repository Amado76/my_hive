import 'package:common_microfrontend/common_microfrontend.dart';

mixin PasswordMatchesValidationMixin {
  final Translation _translation = Modular.get<Translation>();

  String? passwordMatches(String? password, String? confirmPassword) {
    if (password != confirmPassword) {
      return _translation.translate(
        package: "authentication",
        key: "registerPasswordNotMatch",
      );
    }

    return null;
  }
}
