import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/services.dart' show PlatformException;
import 'package:common_microfrontend/common_microfrontend.dart';

/// A classe [SendValidationSmsError] representa erros de no processo de envio de SMS e validação do número.
Map<String, SendValidationSmsError> sendValidationSmsMapping = {
  'O número e ddi não pode estar vazio.': SendValidationSmsEmptyPhoneNumber(),
  'Ocorreu um problema ao enviar o código de validação por SMS.':
      SendValidationSmsSendError(),
  'usuario-cadastrado': SendValidationSmsUserAlreadyRegister(),
};

@immutable
sealed class SendValidationSmsError extends Equatable {
  final String dialogTitle;
  final String dialogText;

  const SendValidationSmsError({
    required this.dialogTitle,
    required this.dialogText,
  });

  /// O método factory cria uma instancia de [SendValidationSmsError] com base em uma [Exception].
  /// [exception] - A [Exception] a partir da qual criar o [SendValidationSmsError].
  /// Retorna um objeto [SendValidationSmsError] correspondente à exceção fornecida,
  /// ou um objeto padrão [SendValidationSmsUnknown] se nenhum mapeamento for encontrado.

  factory SendValidationSmsError.from(Exception exception) {
    if (exception is GTecException) {
      String errorMessage = exception.message;
      return sendValidationSmsMapping[errorMessage] ??
          SendValidationSmsUnknown();
    }
    if (exception is CustomConnectionException) {
      String errorMessage = exception.message;
      return sendValidationSmsMapping[errorMessage] ??
          SendValidationSmsUnknown();
    }
    if (exception is PlatformException) {
      String errorMessage = exception.code;
      return sendValidationSmsMapping[errorMessage] ??
          SendValidationSmsUnknown();
    }

    return SendValidationSmsUnknown();
  }
}

@immutable
class SendValidationSmsUnknown extends SendValidationSmsError {
  SendValidationSmsUnknown()
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
class SendValidationSmsEmptyPhoneNumber extends SendValidationSmsError {
  SendValidationSmsEmptyPhoneNumber()
      : super(
          dialogTitle: Modular.get<Translation>().translate(
              key: "sendValidationSmsEmptyPhoneNumberTitle",
              package: "authentication"),
          dialogText: Modular.get<Translation>().translate(
              key: "sendValidationSmsEmptyPhoneNumberMessage",
              package: "authentication"),
        );

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

class SendValidationSmsSendError extends SendValidationSmsError {
  SendValidationSmsSendError()
      : super(
            dialogTitle: Modular.get<Translation>().translate(
                key: "sendValidationSmsSendErrorTitle",
                package: "authentication"),
            dialogText: Modular.get<Translation>().translate(
              key: "sendValidationSmsSendErrorMessage",
              package: "authentication",
            ));

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

class SendValidationSmsUserAlreadyRegister extends SendValidationSmsError {
  SendValidationSmsUserAlreadyRegister()
      : super(
            dialogTitle: Modular.get<Translation>().translate(
                key: "sendValidationSmsUserAlreadyRegisterTitle",
                package: "authentication"),
            dialogText: Modular.get<Translation>().translate(
              key: "sendValidationSmsUserAlreadyRegisterMessage",
              package: "authentication",
            ));

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}
