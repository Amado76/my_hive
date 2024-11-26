import 'package:common_microfrontend/util/url_injector/url_injector_object.dart';

class MyProfileUrls extends UrlInjectorObject {
  @override
  List<Map<String, dynamic>> get mapData => [
        {
          "package": "my_profile",
          "endpointIdentifier": "readProfile",
          "endpoint": "/apiv5/me",
        },
        {
          "package": "my_profile",
          "endpointIdentifier": "updateProfile",
          "endpoint": "/apiv5/profile/update",
        },
      ];
}
