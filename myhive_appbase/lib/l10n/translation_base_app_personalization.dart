import 'package:common_microfrontend/common_microfrontend.dart';

class TranslationBaseAppPersonalization extends TranslationObject {
  @override
  List<Map<String, dynamic>> get jsonData => [
        portugueseDesignSystemData,
        englishDesignSystemData,
        spanishDesignSystemData,
      ];

  //Design System personalization
  Map<String, dynamic> portugueseDesignSystemData = {
    "language": "pt",
    "business": "myhive",
    "package": "common",
    "translate": {
      "sharedAppLinkContet":
          ''' Entre para nossa comunidade, e faça parte de uma grande família!

📲 Baixe agora:

. Google Play Store:
 Em breve

. App Store:
  Em breve


''',
    }
  };
  Map<String, dynamic> englishDesignSystemData = {
    "language": "en",
    "business": "myhive",
    "package": "common",
    "translate": {
      "sharedAppLinkContet": '''
  Enter our community, and be part of a great family!

📲 Download now:

. Google Play Store:
Soon

. App Store:
Soon

'''
    }
  };
  Map<String, dynamic> spanishDesignSystemData = {
    "language": "es",
    "business": "myhive",
    "package": "common",
    "translate": {
      "sharedAppLinkContet": '''
  ¡Únete a nuestra comunidad y forma parte de una gran familia!

📲 ¡Descarga ahora!

. Google Play Store:
Próximamente

. App Store:
Próximamente
'''
    }
  };
}
