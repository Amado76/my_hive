import 'package:common_microfrontend/common_microfrontend.dart';

class TranslationMock extends TranslationObject {
  @override
  List<Map<String, dynamic>> jsonData = [
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
    }
  ];
}
