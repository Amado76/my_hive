import 'package:common_microfrontend/util/url_injector/url_injector_object.dart';

class FeedUrls extends UrlInjectorObject {
  @override
  List<Map<String, dynamic>> get mapData => [
        {
          "package": "feed",
          "endpointIdentifier": "listFeed",
          "endpoint": "/apiv3/tips",
        },
        {
          "package": "feed",
          "endpointIdentifier": "singleFeedDetail",
          "endpoint": "/apiv3/tips/details",
        }
      ];
}
