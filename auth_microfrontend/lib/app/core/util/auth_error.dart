import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/services.dart' show PlatformException;
import 'package:common_microfrontend/common_microfrontend.dart';

/// A classe [AuthError] representa erros de no processo de autenticação
Map<String, AuthError> authErrorMapping = {
  'Houve um erro ao enviar a sua solicitação': AuthErrorUnknown(),
  'Email inválido': AuthErrorInvalidEmail(),
  'Este campo não pode ser em branco.': AuthErrorEmptyData(),
  'Impossível fazer login com as credenciais fornecidas.':
      AuthErrorInvalidCredentials(),
  'Nome não pode ser vazio': AuthErrorEmptyName(),
  'Número de telefone nome não pode ser vazio': AuthErrorEmptyPhoneNumber(),
  'E-mail nome não pode ser vazio': AuthErrorEmptyEmail(),
  'Senha nome não pode ser vazio': AuthErrorEmptyPassword(),
  'Código da turma não pode ser vazio': AuthErrorEmptyClass(),
  'Este número de telefone já existe': AuthErrorPhoneNumberAlreadyInUse(),
  'Este e-mail não é valido': AuthErrorInvalidEmail(),
  'Esse e-mail já está em uso, tente recuperar sua senha.':
      AuthErrorEmailAlreadyInUse(),
  'Código da turma inválido ou expirou.': AuthErrorInvalidClass(),
  'Essa comunidade exige o cadastro do CPF': AuthErrorEmptyCPF(),
  'CPF_EXISTENTE': AuthErrorCpfAlreadyInUse(),
  'Este cpf já está cadastrado': AuthErrorCpfAlreadyInUse(),
  'Esse usuário já existe': AuthErrorUserAlreadyExists(),
  'Erro ao Salvar imagem de perfil': AuthErrorOnSaveAvatar(),
  'Erro ao criar um aluno associado ao usuário {identifier}': AuthErrorUnknown()
};

@immutable
sealed class AuthError extends Equatable {
  final String dialogTitle;
  final String dialogText;

  const AuthError({
    required this.dialogTitle,
    required this.dialogText,
  });

  /// O método factory cria uma instancia de [AuthError] com base em uma [Exception].
  /// [exception] - A [Exception] a partir da qual criar o [AuthError].
  /// Retorna um objeto [AuthError] correspondente à exceção fornecida,
  /// ou um objeto padrão [AuthErrorUnknown] se nenhum mapeamento for encontrado.

  factory AuthError.from(Exception exception) {
    if (exception is GTecException) {
      String errorMessage = exception.message;
      return authErrorMapping[errorMessage] ?? AuthErrorUnknown();
    }
    if (exception is CustomConnectionException) {
      String errorMessage = exception.message;
      return authErrorMapping[errorMessage] ?? AuthErrorUnknown();
    }
    if (exception is PlatformException) {
      String errorMessage = exception.code;
      return authErrorMapping[errorMessage] ?? AuthErrorUnknown();
    }

    String errorMessage = exception.toString();
    return authErrorMapping[errorMessage] ?? AuthErrorUnknown();
  }
}

@immutable
class AuthErrorUnknown extends AuthError {
  AuthErrorUnknown()
      : super(
          dialogTitle: Modular.get<Translation>().translate(
              key: "authErrorUnknownTitle", package: "authentication"),
          dialogText: Modular.get<Translation>().translate(
              key: "authErrorUnknownMessage", package: "authentication"),
        );

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class AuthErrorInvalidEmail extends AuthError {
  AuthErrorInvalidEmail()
      : super(
            dialogTitle: Modular.get<Translation>().translate(
                key: "authErrorInvalidEmailTitle", package: "authentication"),
            dialogText: Modular.get<Translation>().translate(
                key: "authErrorInvalidEmailMessage",
                package: "authentication"));

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class AuthErrorEmptyData extends AuthError {
  AuthErrorEmptyData()
      : super(
            dialogTitle: Modular.get<Translation>().translate(
                key: "authErrorEmptyDatalTitle", package: "authentication"),
            dialogText: Modular.get<Translation>().translate(
                key: "authErrorEmptyDataMessage", package: "authentication"));

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class AuthErrorInvalidCredentials extends AuthError {
  AuthErrorInvalidCredentials()
      : super(
            dialogTitle: Modular.get<Translation>().translate(
                key: "authErrorInvalidCredentialsTitle",
                package: "authentication"),
            dialogText: Modular.get<Translation>().translate(
                key: "authErrorInvalidCredentialsMessage",
                package: "authentication"));

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class AuthErrorEmptyName extends AuthError {
  AuthErrorEmptyName()
      : super(
            dialogTitle: Modular.get<Translation>().translate(
                key: "authErrorEmptyNameTitle", package: "authentication"),
            dialogText: Modular.get<Translation>().translate(
                key: "authErrorEmptyNameMessage", package: "authentication"));

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class AuthErrorEmptyPhoneNumber extends AuthError {
  AuthErrorEmptyPhoneNumber()
      : super(
            dialogTitle: Modular.get<Translation>().translate(
                key: "authErrorEmptyPhoneNumberTitle",
                package: "authentication"),
            dialogText: Modular.get<Translation>().translate(
                key: "authErrorEmptyPhoneNumberMessage",
                package: "authentication"));

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class AuthErrorEmptyEmail extends AuthError {
  AuthErrorEmptyEmail()
      : super(
            dialogTitle: Modular.get<Translation>().translate(
                key: "authErrorEmptyEmailTitle", package: "authentication"),
            dialogText: Modular.get<Translation>().translate(
                key: "authErrorEmptyEmailMessage", package: "authentication"));

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class AuthErrorEmptyPassword extends AuthError {
  AuthErrorEmptyPassword()
      : super(
            dialogTitle: Modular.get<Translation>().translate(
                key: "authErrorEmptyPasswordTitle", package: "authentication"),
            dialogText: Modular.get<Translation>().translate(
                key: "authErrorEmptyPasswordMessage",
                package: "authentication"));

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class AuthErrorEmptyClass extends AuthError {
  AuthErrorEmptyClass()
      : super(
            dialogTitle: Modular.get<Translation>().translate(
                key: "authErrorEmptyClassTitle", package: "authentication"),
            dialogText: Modular.get<Translation>().translate(
                key: "authErrorEmptyClassMessage", package: "authentication"));

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class AuthErrorPhoneNumberAlreadyInUse extends AuthError {
  AuthErrorPhoneNumberAlreadyInUse()
      : super(
            dialogTitle: Modular.get<Translation>().translate(
                key: "authErrorPhoneNumberAlreadyInUseTitle",
                package: "authentication"),
            dialogText: Modular.get<Translation>().translate(
                key: "authErrorPhoneNumberAlreadyInUseMessage",
                package: "authentication"));

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class AuthErrorEmailAlreadyInUse extends AuthError {
  AuthErrorEmailAlreadyInUse()
      : super(
          dialogTitle: Modular.get<Translation>().translate(
              key: "authErrorEmailAlreadyInUseTitle",
              package: "authentication"),
          dialogText: Modular.get<Translation>().translate(
              key: "authErrorEmailAlreadyInUseMessage",
              package: "authentication"),
        );

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class AuthErrorInvalidClass extends AuthError {
  AuthErrorInvalidClass()
      : super(
            dialogTitle: Modular.get<Translation>().translate(
                key: "authErrorInvalidClassTitle", package: "authentication"),
            dialogText: Modular.get<Translation>().translate(
                key: "authErrorInvalidClassMessage",
                package: "authentication"));

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class AuthErrorEmptyCPF extends AuthError {
  AuthErrorEmptyCPF()
      : super(
          dialogTitle: Modular.get<Translation>().translate(
              key: "authErrorEmptyCPFTitle", package: "authentication"),
          dialogText: Modular.get<Translation>().translate(
              key: "authErrorEmptyCPFMessage", package: "authentication"),
        );
  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class AuthErrorCpfAlreadyInUse extends AuthError {
  AuthErrorCpfAlreadyInUse()
      : super(
            dialogTitle: Modular.get<Translation>().translate(
                key: "authErrorCpfAlreadyInUseTitle",
                package: "authentication"),
            dialogText: Modular.get<Translation>().translate(
                key: "authErrorCpfAlreadyInUseMessage",
                package: "authentication"));
  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class AuthErrorUserAlreadyExists extends AuthError {
  AuthErrorUserAlreadyExists()
      : super(
            dialogTitle: Modular.get<Translation>().translate(
                key: "authErrorUserAlreadyExistsTitle",
                package: "authentication"),
            dialogText: Modular.get<Translation>().translate(
                key: "authErrorUserAlreadyExistsMessage",
                package: "authentication"));
  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class AuthErrorOnSaveAvatar extends AuthError {
  AuthErrorOnSaveAvatar()
      : super(
            dialogTitle: Modular.get<Translation>().translate(
                key: "authErrorOnSaveAvatarTitle", package: "authentication"),
            dialogText: Modular.get<Translation>().translate(
                key: "authErrorOnSaveAvatarMessage",
                package: "authentication"));
  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}
