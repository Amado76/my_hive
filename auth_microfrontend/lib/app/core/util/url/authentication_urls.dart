import 'package:common_microfrontend/util/url_injector/url_injector_object.dart';

class AuthenticationUrls extends UrlInjectorObject {
  @override
  List<Map<String, dynamic>> get mapData => [
        {
          "package": "authentication",
          "endpointIdentifier": "login",
          "endpoint": "/apiv3/login",
        },
        {
          "package": "authentication",
          "endpointIdentifier": "sign_up",
          "endpoint": "/apiv4/sign_up",
        },
        {
          "package": "authentication",
          "endpointIdentifier": "sendValidationSMS",
          "endpoint": "/apiv3/number/check",
        },
        {
          "package": "authentication",
          "endpointIdentifier": "verifyPhoneNumber",
          "endpoint": "/apiv3/number/verify",
        },
        {
          "package": "authentication",
          "endpointIdentifier": "resetPassword",
          "endpoint": "/apiv3/reset_password",
        },
      ];
}
