import 'package:common_microfrontend/util/translation/domain/entity/translation_object.dart';

class TranslationFeed extends TranslationObject {
  @override
  List<Map<String, dynamic>> get jsonData =>
      [portugueseData, englishData, spanishData];

  Map<String, dynamic> portugueseData = {
    "language": "pt",
    "business": "general",
    "package": "feed",
    "translate": {
      // Tradução de erros
      "unknownErrorTitle": "Oops, aconteceu um erro!",
      "unknownErrorText":
          "Algo deu errado, por favor, tente novamente mais tarde.",
      "emptyFeed": "Nenhum feed para esta semana",
      "launchUrlErrorTitle": "Não foi possível abrir o link!",
      "launchUrlErrorText":
          "Oops! Parece que houve um problema ao tentar abrir o link. Por favor, tente novamente mais tarde.",
      "launchUrlErrorButton": "Okay!",

      // Tradução de elementos da tela
      "pageTitle": "Feed",
    }
  };

  Map<String, dynamic> englishData = {
    "language": "en",
    "business": "general",
    "package": "feed",
    "translate": {
      // Tradução de erros
      "unknownErrorTitle": "Oops, an error occurred!",
      "unknownErrorText": "Something went wrong, please try again later.",
      "emptyFeed": "No feed available for now",
      "launchUrlErrorTitle": "Something went wrong!",
      "launchUrlErrorText":
          "Oops! It looks like there was a problem with the link you are trying to open. Please try again later.",
      "launchUrlErrorButton": "Okay!",

      // Tradução de elementos da tela
      "pageTitle": "Feed",
    }
  };

  Map<String, dynamic> spanishData = {
    "language": "es",
    "business": "general",
    "package": "feed",
    "translate": {
      // Tradução de erros
      "unknownErrorTitle": "¡Ups, ocurrió un error!",
      "unknownErrorText":
          "Algo salió mal, por favor, inténtelo de nuevo más tarde.",
      "emptyFeed": "No hay feed para esta semana",
      "launchUrlErrorTitle": "No se pudo abrir el link!",
      "launchUrlErrorText":
          "¡Ups! Parece que hubo un problema al intentar abrir el link. Por favor, inténtelo de nuevo más tarde.",
      "launchUrlErrorButton": "Okay!",

      // Tradução de elementos da tela
      "pageTitle": "Feed",
    }
  };
}
