import 'package:common_microfrontend/util/url_injector/url_injector_object.dart';

class UserUrls extends UrlInjectorObject {
  @override
  List<Map<String, dynamic>> get mapData => [
        {
          "package": "user_common",
          "endpointIdentifier": "get_me",
          "endpoint": "/apiv5/me",
        },
        {
          "package": "user_common",
          "endpointIdentifier": "get_current_profile",
          "endpoint": "/apiv5/me/profile",
        },
        {
          "package": "user_common",
          "endpointIdentifier": "get_profiles",
          "endpoint": "/apiv5/me/profiles",
        },
        {
          "package": "user_common",
          "endpointIdentifier": "get_modules_auth",
          "endpoint": "/apiv3/sys/modules_auth",
        },
        {
          "package": "user_common",
          "endpointIdentifier": "choose_profile",
          "endpoint": "/apiv3/me/chose_group",
        },
      ];
}
