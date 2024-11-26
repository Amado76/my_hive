import 'package:feed_microfrontend/app/domain/entities/feed_entity.dart';
import 'package:feed_microfrontend/app/domain/repository/feed_repository_interface.dart';
import 'package:common_microfrontend/util/http_client/http_client_adapter.dart';
import 'package:common_microfrontend/util/url_injector/url_injector.dart';

class FeedRepositoryImpl implements FeedRepositoryInterface {
  final HttpClientInterface _httpClient;
  final UrlInjector _urlInjector;

  FeedRepositoryImpl({
    required HttpClientInterface httpClient,
    required UrlInjector urlInjector,
  })  : _httpClient = httpClient,
        _urlInjector = urlInjector;

  @override
  Future<List<FeedEntity>> getFeed() async {
    final url = _urlInjector.getEndPoint(endpoint: 'listFeed', package: 'feed');
    final response = await _httpClient.get(path: url);
    final data = response.data['data'] as List;

    return data.map((e) => FeedEntity.fromJson(e)).toList();
  }

  @override
  Future<FeedEntity> getSingleFeed(int id) async {
    final url =
        _urlInjector.getEndPoint(endpoint: 'singleFeedDetail', package: 'feed');
    final response =
        await _httpClient.get(path: url, queryParameters: {'tip_id': id});
    final data = response.data['data'] as Map<String, dynamic>;

    return FeedEntity.fromJson(data);
  }
}
