import 'package:common_microfrontend/common_microfrontend.dart';

class TranslationMock extends TranslationObject {
  TranslationMock() {
    jsonData.addAll(jsonDataEN);
    jsonData.addAll(jsonDataPT);
    jsonData.addAll(jsonDataGeneralBusiness);
  }

  List<Map<String, dynamic>> jsonDataGeneralBusiness = [
    {
      "language": "en",
      "business": "general",
      "package": "login",
      "translate": {
        "generaltranslate": "This translate are only for not found business",
        "generaltranslate2": "This translate are only for not found business2",
      }
    },
    {
      "language": "pt",
      "business": "general",
      "package": "login",
      "translate": {
        "generaltranslate":
            "Esta tradução é apenas para negócios não encontrados",
        "generaltranslate2":
            "Esta tradução é apenas para negócios não encontrados2",
      }
    },
  ];

  List<Map<String, dynamic>> jsonDataEN = [
    {
      "language": "en",
      "business": "general",
      "package": "login",
      "translate": {
        "cliquelogin": "click to login soccer",
        "bomdia": "good morning soccer",
        "boanoite": "good night soccer",
        "boatarde": "good afternoon soccer",
        "withargs": "good afternoon soccer {0}, {1}",
      }
    },
    {
      "language": "en",
      "business": "idioma",
      "package": "login",
      "translate": {
        "cliquelogin": "click to login student",
        "bomdia": "good morning student",
        "boanoite": "good night student",
        "boatarde": "good afternoon student",
        "witharsArgs": "good afternoon student {0}, {1}",
      }
    },
  ];

  List<Map<String, dynamic>> jsonDataPT = [
    {
      "language": "pt",
      "business": "general",
      "package": "login",
      "translate": {
        "cliquelogin": "Clique para logar jogador",
        "bomdia": "Bom dia jogador",
        "boanoite": "Boa noite jogador",
        "boatarde": "Boa tarde jogador",
        "withargs": "Boa tarde jogador {0}, {1}",
      }
    },
    {
      "language": "pt",
      "business": "idioma",
      "package": "login",
      "translate": {
        "cliquelogin": "Clique para logar aluno",
        "bomdia": "Bom dia aluno",
        "boanoite": "Boa noite aluno",
        "boatarde": "Boa tarde aluno",
        "withargs": "Boa tarde aluno {0}, {1}",
      }
    },
  ];

  @override
  List<Map<String, dynamic>> jsonData = [];
}
