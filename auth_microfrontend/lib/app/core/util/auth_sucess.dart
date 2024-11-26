import 'package:flutter/foundation.dart' show immutable;
import 'package:common_microfrontend/common_microfrontend.dart';

/// A classe [AuthSuccess] representa mensagens de sucesso no processo de envio de autenticação.
Map<String, AuthSuccess> authSuccessMapping = {
  'Email de recuperação enviado com sucesso': AuthSuccessRecoveryEmailSent(),
};

@immutable
sealed class AuthSuccess extends Equatable {
  final String dialogTitle;
  final String dialogText;

  const AuthSuccess({
    required this.dialogTitle,
    required this.dialogText,
  });

  /// O método factory cria uma instancia de [AuthSuccess] com base em uma [successMessage].
  /// [successMessage] - A [String] a partir da qual criar o [AuthSuccess].
  /// Retorna um objeto [AuthSuccess] correspondente à successMessage fornecida,
  /// ou um objeto padrão [AuthSuccessUnknown] se nenhum mapeamento for encontrado.

  factory AuthSuccess.from(String successMessage) {
    return authSuccessMapping[successMessage] ?? AuthSuccessUnknown();
  }
}

@immutable
class AuthSuccessUnknown extends AuthSuccess {
  AuthSuccessUnknown()
      : super(
            dialogTitle: Modular.get<Translation>().translate(
                package: "authentication", key: "authSuccessUnknownTitle"),
            dialogText: Modular.get<Translation>().translate(
                package: "authentication", key: "authSuccessUnknownMessage"));

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class AuthSuccessRecoveryEmailSent extends AuthSuccess {
  AuthSuccessRecoveryEmailSent()
      : super(
            dialogTitle: Modular.get<Translation>().translate(
                package: "authentication",
                key: "authSuccessRecoveryEmailSentTitle"),
            dialogText: Modular.get<Translation>().translate(
                package: "authentication",
                key: "authSuccessRecoveryEmailSentMessage"));

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}
