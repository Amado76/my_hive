import 'package:common_microfrontend/common_microfrontend.dart';

class HomeUrls extends UrlInjectorObject {
  @override
  List<Map<String, dynamic>> get mapData => [
        {
          "package": "home",
          "endpointIdentifier": "acceptTerms",
          "endpoint": "/apiv3/sys/user_terms_lgpd",
        },
        {
          "package": "home",
          "endpointIdentifier": "verifyTerms",
          "endpoint": "/apiv3/sys/verify_terms_lgpd",
        },
        {
          "package": "home",
          "endpointIdentifier": "getTerms",
          "endpoint": "/apiv3/sys/terms",
        },
        {
          "package": "home",
          "endpointIdentifier": "getHomeData",
          "endpoint": "/apiv3/user/home",
        },
        {
          "package": "home",
          "endpointIdentifier": "hasCommunicationNotifications",
          "endpoint": "/apiv3/me/pending_notifications",
        },
      ];
}
