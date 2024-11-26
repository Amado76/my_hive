import 'package:common_microfrontend/util/url_injector/url_injector_object.dart';

class ThemeUrls extends UrlInjectorObject {
  @override
  List<Map<String, dynamic>> get mapData => [
        {
          "package": "theme_and_colors",
          "endpointIdentifier": "current_theme",
          "endpoint": "/apiv3/sys/current_theme",
        },
      ];
}
