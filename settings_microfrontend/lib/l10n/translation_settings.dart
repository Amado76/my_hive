import 'package:common_microfrontend/common_microfrontend.dart';

class TranslationSettings extends TranslationObject {
  TranslationSettings() {
    jsonData.addAll(jsonDataEN);
    jsonData.addAll(jsonDataPT);
    jsonData.addAll(jsonDataES);
  }

  final List<Map<String, dynamic>> jsonDataPT = [
    {
      "language": "pt",
      "business": "general",
      "package": "settings",
      "translate": {
        "titleAppBar": "Configurações",
        "errorStateTitle": "Erro ao carregar configurações",
        "languageMenu": "Idioma",
        "languagePt": "Português BR",
        "languageEn": "Inglês",
        "languageEs": "Espanhol",
        "notificationTitle": "Notificações",
        "notificationSubtitle": "Ativar/Desativar notificações no celular",
        "unsupportedPlatform": "Plataforma não suportada",
        "requestAccountDeletionTitle": "Solicitar exclusão da conta",
        "requestAccountDeletionSubtitle":
            "Solicitar a exclusão da conta e todos os dados associados",
        "successRequestAccountDeletionTitle": "Solicitação enviada com sucesso",
        "successRequestAccountDeletionSubtitle":
            "Foi enviado um e-mail com as instruções para a exclusão da conta."
      }
    }
  ];

  final List<Map<String, dynamic>> jsonDataEN = [
    {
      "language": "en",
      "business": "general",
      "package": "settings",
      "translate": {
        "titleAppBar": "Settings",
        "errorStateTitle": "Error loading settings",
        "languageMenu": "Language",
        "languagePt": "Portuguese BR",
        "languageEn": "English",
        "languageEs": "Spanish",
        "notificationTitle": "Notifications",
        "notificationSubtitle": "Enable/Disable notifications on the phone",
        "unsupportedPlatform": "Unsupported platform",
        "requestAccountDeletionTitle": "Request account deletion",
        "requestAccountDeletionSubtitle":
            "Request the deletion of the account and all associated data",
        "successRequestAccountDeletionTitle": "Request sent successfully",
        "successRequestAccountDeletionSubtitle":
            "An email has been sent with instructions for deleting the account."
      }
    }
  ];

  final List<Map<String, dynamic>> jsonDataES = [
    {
      "language": "es",
      "business": "general",
      "package": "settings",
      "translate": {
        "titleAppBar": "Configuraciones",
        "errorStateTitle": "Error al cargar configuraciones",
        "languageMenu": "Idioma",
        "languagePt": "Portugués BR",
        "languageEn": "Inglés",
        "languageEs": "Español",
        "notificationTitle": "Notificaciones",
        "notificationSubtitle":
            "Activar/Desactivar notificaciones en el celular",
        "unsupportedPlatform": "Plataforma no soportada",
        "requestAccountDeletionTitle": "Solicitar eliminación de cuenta",
        "requestAccountDeletionSubtitle":
            "Solicitar la eliminación de la cuenta y todos los datos asociados",
        "successRequestAccountDeletionTitle": "Solicitud enviada con éxito",
        "successRequestAccountDeletionSubtitle":
            "Se ha enviado un correo electrónico con instrucciones para eliminar la cuenta."
      }
    }
  ];

  @override
  final List<Map<String, dynamic>> jsonData = [];
}
