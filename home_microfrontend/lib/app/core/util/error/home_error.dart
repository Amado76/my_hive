import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/services.dart' show PlatformException;

/// A classe [HomeError] representa erros de no processo de autenticação
Map<String, HomeError> homeErrorMapping = {
  'Não foi possível identificar o usuário COD 6653': HomeUserNotFound(),
  'Não foi possível completar essa operação': HomeErrorUnknown(),
  'Os termos de uso não foram definidos': HomeErrorTermsOfUseNotDefined(),
  'Não foi possível identificar o usuário': HomeUserNotFound(),
  'nao-foi-possivel-abrir-o-link': HomeErrorLinkNotFound(),
};

@immutable
sealed class HomeError extends Equatable {
  final String dialogTitle;
  final String dialogText;

  const HomeError({
    required this.dialogTitle,
    required this.dialogText,
  });

  /// O método factory cria uma instancia de [HomeError] com base em uma [Exception].
  /// [exception] - A [Exception] a partir da qual criar o [HomeError].
  /// Retorna um objeto [HomeError] correspondente à exceção fornecida,
  /// ou um objeto padrão [HomeErrorUnknown] se nenhum mapeamento for encontrado.

  factory HomeError.from(Exception exception) {
    if (exception is GTecException) {
      String errorMessage = exception.message;
      return homeErrorMapping[errorMessage] ?? HomeErrorUnknown();
    }
    if (exception is CustomConnectionException) {
      String errorMessage = exception.message;
      return homeErrorMapping[errorMessage] ?? HomeErrorUnknown();
    }
    if (exception is PlatformException) {
      String errorMessage = exception.code;
      return homeErrorMapping[errorMessage] ?? HomeErrorUnknown();
    }

    String errorMessage = exception.toString();
    return homeErrorMapping[errorMessage] ?? HomeErrorUnknown();
  }
}

@immutable
class HomeErrorUnknown extends HomeError {
  HomeErrorUnknown()
      : super(
          dialogTitle: Modular.get<Translation>()
              .translate(key: "homeErrorUnknownTitle", package: "home"),
          dialogText: Modular.get<Translation>()
              .translate(key: "homeErrorUnknownMessage", package: "home"),
        );

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class HomeUserNotFound extends HomeError {
  HomeUserNotFound()
      : super(
          dialogTitle: Modular.get<Translation>()
              .translate(key: "homeErrorUserNotFoundTitle", package: "home"),
          dialogText: Modular.get<Translation>()
              .translate(key: "homeErrorUserNotFoundMessage", package: "home"),
        );

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class HomeErrorTermsOfUseNotDefined extends HomeError {
  HomeErrorTermsOfUseNotDefined()
      : super(
          dialogTitle: Modular.get<Translation>().translate(
              key: "homeErrorTermsOfUseNotDefinedTitle", package: "home"),
          dialogText: Modular.get<Translation>().translate(
              key: "homeErrorTermsOfUseNotDefinedMessage", package: "home"),
        );

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}

@immutable
class HomeErrorLinkNotFound extends HomeError {
  HomeErrorLinkNotFound()
      : super(
          dialogTitle: Modular.get<Translation>()
              .translate(key: "homeErrorLinkNotFoundTitle", package: "home"),
          dialogText: Modular.get<Translation>()
              .translate(key: "homeErrorLinkNotFoundMessage", package: "home"),
        );

  @override
  List<Object?> get props => [super.dialogText, super.dialogTitle];
}
