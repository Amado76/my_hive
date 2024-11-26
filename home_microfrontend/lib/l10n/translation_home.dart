import 'package:common_microfrontend/util/translation/domain/entity/translation_object.dart';

class TranslationHome extends TranslationObject {
  @override
  List<Map<String, dynamic>> get jsonData => [
        portugueseBusinessJsonData,
        englishBusinessJsonData,
        spanishBusinessJsonData,
      ];

  Map<String, dynamic> portugueseBusinessJsonData = {
    "language": "pt",
    "business": "general",
    "package": "home",
    "translate": {
      //Terms
      "termsOfUse": "Termos de uso",
      "accept": "Aceitar",
      "decline": "Recusar",

      //ModulesNames
      "home": "Início",
      "communication": "Comunicados",
      "feed": "Feed",
      "seeMore": "Ver mais",
      "myProfile": "Meu Perfil",

      //HomeError
      "homeErrorUnknownTitle": "Erro desconhecido",
      "homeErrorUnknownMessage":
          "Ocorreu um erro desconhecido. Por favor, tente novamente mais tarde.",
      "homeErrorUserNotFoundTitle": "Usuário não encontrado",
      "homeErrorUserNotFoundMessage":
          "Não foi possível identificar o usuário. Confirme seu usuário.",
      "homeErrorTermsOfUseNotDefinedTitle": "Termos de uso não definidos",
      "homeErrorTermsOfUseNotDefinedMessage":
          "Os termos de uso não foram definidos.",
      "homeErrorLinkNotFoundTitle": "Link não encontrado",
      "homeErrorLinkNotFoundMessage":
          "Não foi possível abrir o link. Tente novamente, se o erro persistir, entre em contato com o suporte.",
      "imageError": "Erro ao carregar a imagem",
    }
  };
  Map<String, dynamic> englishBusinessJsonData = {
    "language": "en",
    "business": "general",
    "package": "home",
    "translate": {
      //Terms
      "termsOfUse": "Terms of use",
      "accept": "Accept",
      "decline": "Decline",
      //ModulesNames
      "home": "Home",
      "communication": "Communication",
      "feed": "Feed",
      "seeMore": "See more",
      "myProfile": "My Profile",
      //HomeError
      "homeErrorUnknownTitle": "Unknown error",
      "homeErrorUnknownMessage":
          "An unknown error occurred. Please try again later.",
      "homeErrorUserNotFoundTitle": "User not found",
      "homeErrorUserNotFoundMessage":
          "Could not identify the user. Confirm your user.",
      "homeErrorTermsOfUseNotDefinedTitle": "Terms of use not defined",
      "homeErrorTermsOfUseNotDefinedMessage":
          "The terms of use have not been defined.",
      "homeErrorLinkNotFoundTitle": "Link not found",
      "homeErrorLinkNotFoundMessage":
          "Could not open the link. Try again, if the error persists, contact support.",
      "imageError": "Error loading image",
    }
  };

  Map<String, dynamic> spanishBusinessJsonData = {
    "language": "es",
    "business": "general",
    "package": "home",
    "translate": {
      //Terms
      "termsOfUse": "Términos de uso",
      "accept": "Aceptar",
      "decline": "Rechazar",

      //ModulesNames
      "home": "Inicio",
      "communication": "Comunicados",
      "feed": "Feed",
      "webtv": "WebTV",
      "myProfile": "Mi Perfil",

      //HomeError
      "homeErrorUnknownTitle": "Error desconocido",
      "homeErrorUnknownMessage":
          "Se produjo un error desconocido. Por favor, inténtelo de nuevo más tarde.",
      "homeErrorUserNotFoundTitle": "Usuario no encontrado",
      "homeErrorUserNotFoundMessage":
          "No se pudo identificar al usuario. Confirme su usuario.",
      "homeErrorTermsOfUseNotDefinedTitle": "Términos de uso no definidos",
      "homeErrorTermsOfUseNotDefinedMessage":
          "Los términos de uso no han sido definidos.",
      "homeErrorLinkNotFoundTitle": "Enlace no encontrado",
      "homeErrorLinkNotFoundMessage":
          "No se pudo abrir el enlace. Inténtelo de nuevo, si el error persiste, póngase en contacto con el soporte.",
      "imageError": "Error al cargar la imagen",
    }
  };
}
