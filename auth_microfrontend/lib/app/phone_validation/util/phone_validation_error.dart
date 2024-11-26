import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/services.dart' show PlatformException;
import 'package:common_microfrontend/common_microfrontend.dart';

/// A classe [PhoneValidationError] representa erros de no processo de envio de SMS e validação do número.
Map<String, PhoneValidationError> phoneValidatioMapping = {
  'Código inválido.': PhoneValidationInvalidCode(),
};

@immutable
sealed class PhoneValidationError extends Equatable {
  final String dialogTitle;
  final String dialogText;

  const PhoneValidationError({
    required this.dialogTitle,
    required this.dialogText,
  });

  /// O método factory cria uma instancia de [PhoneValidationError] com base em uma [Exception].
  /// [exception] - A [Exception] a partir da qual criar o [PhoneValidationError].
  /// Retorna um objeto [PhoneValidationError] correspondente à exceção fornecida,
  /// ou um objeto padrão [PhoneValidationUnknown] se nenhum mapeamento for encontrado.

  factory PhoneValidationError.from(Exception exception) {
    if (exception is GTecException) {
      String errorMessage = exception.message;
      return phoneValidatioMapping[errorMessage] ?? PhoneValidationUnknown();
    }
    if (exception is CustomConnectionException) {
      String errorMessage = exception.message;
      return phoneValidatioMapping[errorMessage] ?? PhoneValidationUnknown();
    }
    if (exception is PlatformException) {
      String errorMessage = exception.code;
      return phoneValidatioMapping[errorMessage] ?? PhoneValidationUnknown();
    }

    return PhoneValidationUnknown();
  }
}

@immutable
class PhoneValidationUnknown extends PhoneValidationError {
  PhoneValidationUnknown()
      : super(
            dialogTitle: Modular.get<Translation>().translate(
                key: "phoneValidationUnknownTitle", package: "authentication"),
            dialogText: Modular.get<Translation>().translate(
                key: "phoneValidationUnknownMessage",
                package: "authentication"));

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class PhoneValidationInvalidCode extends PhoneValidationError {
  PhoneValidationInvalidCode()
      : super(
            dialogTitle: Modular.get<Translation>().translate(
                key: "phoneValidationInvalidCodeTitle",
                package: "authentication"),
            dialogText: Modular.get<Translation>().translate(
                key: "phoneValidationInvalidCodeMessage",
                package: "authentication"));

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}
