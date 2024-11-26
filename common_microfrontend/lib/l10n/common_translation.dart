import 'package:common_microfrontend/util/translation/domain/entity/translation_object.dart';

class CommonTranslation extends TranslationObject {
  @override
  List<Map<String, dynamic>> get jsonData => [
        portugueseBusinessJsonData,
        englishBusinessJsonData,
        spanishBusinessJsonData,
      ];

  Map<String, dynamic> portugueseBusinessJsonData = {
    "language": "pt",
    "business": "general",
    "package": "common",
    "translate": {
      //AlertDialog
      "alertDialogClose": "Fechar",
      "profile": "Perfil",
      "route_not_found": "Rota não encontrada",
      "change_profile": "Trocar Perfil",
      "my_profile": "Meu Perfil",
      "Início": "Início",
      "Treinadores": "Treinadores",
      "Feed": "Feed",
      //SharedContent
      "sharedAppLinkContet": "",
      //Validation
      "validationRequiredField": "Este campo é obrigatório",
      "validationMinLength": "Este campo deve ter no mínimo {0} caracteres",
      "validationMaxLength": "Este campo deve ter no máximo {0} caracteres",
      "validationInvalidCpf": "CPF inválido",
      "validationInvalidEmail": "E-mail inválido",
      "validationInvalidDate": "Data inválida",
      "validationNotEqual": "Este campo deve ser igual ao outro campo.",
      "profileNotFoundForUser": "Perfil não encontrado para o usuário",
    }
  };
  Map<String, dynamic> englishBusinessJsonData = {
    "language": "en",
    "business": "general",
    "package": "common",
    "translate": {
      "alertDialogClose": "Close",
      "profile": "Profile",
      "route_not_found": "Route not found",
      "change_profile": "Change Profile",
      "my_profile": "My Profile",
      "Início": "Home",

      "Comunicados": "Communication",

      "Feed": "Feed",

      //SharedContent
      "sharedAppLinkContet": "",
      //Validation
      "validationRequiredField": "This field is required",
      "validationMinLength": "This field must have at least {0} characters",
      "validationMaxLength": "This field must have at most {0} characters",
      "validationInvalidCpf": "Invalid document number",
      "validationInvalidEmail": "Invalid e-mail",
      "validationInvalidDate": "Invalid date",
      "validationNotEqual": "This field must be equal to the other field.",
      "profileNotFoundForUser": "Profile not found for user",
    }
  };

  Map<String, dynamic> spanishBusinessJsonData = {
    "language": "es",
    "business": "general",
    "package": "common",
    "translate": {
      "alertDialogClose": "Cerrar",
      "profile": "Perfil",
      "route_not_found": "Ruta no encontrada",
      "change_profile": "Cambiar Perfil",
      "my_profile": "Mi Perfil",
      "Início": "Inicio",

      "Comunicados": "Comunicados",

      "Feed": "Feed",

      //SharedContent
      "sharedAppLinkContet": "",
      //Validation
      "validationRequiredField": "Este campo es obligatorio",
      "validationMinLength": "Este campo debe tener al menos {0} caracteres",
      "validationMaxLength": "Este campo debe tener como máximo {0} caracteres",
      "validationInvalidCpf": "CPF inválido",
      "validationInvalidEmail": "E-mail inválido",
      "validationInvalidDate": "Fecha inválida",
      "validationNotEqual": "Este campo debe ser igual al otro campo.",
      "profileNotFoundForUser": "Perfil no encontrado para el usuario",
    }
  };
}
