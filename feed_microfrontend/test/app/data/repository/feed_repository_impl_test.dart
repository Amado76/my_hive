import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:feed_microfrontend/app/data/repository/feed_repository_impl.dart';
import 'package:feed_microfrontend/app/domain/entities/feed_entity.dart';
import 'package:feed_microfrontend/app/domain/repository/feed_repository_interface.dart';
import 'package:common_microfrontend/util/http_client/http_client_adapter.dart';
import 'package:common_microfrontend/util/url_injector/url_injector.dart';
import 'package:mocktail/mocktail.dart';

import '../../../util/response_mocks.dart';

class UrlInjectorMock extends Mock implements UrlInjector {}

class HttpClientAdapterMock extends Mock implements DioAdapter {}

void main() {
  late HttpClientInterface httpClientAdapterMock;
  late UrlInjector urlInjectorMock;
  late FeedRepositoryInterface feedRepositoryInterface;
  late String listFeedUrl;
  late String singleFeedUrl;

  setUp(() => {
        httpClientAdapterMock = HttpClientAdapterMock(),
        urlInjectorMock = UrlInjectorMock(),
        feedRepositoryInterface = FeedRepositoryImpl(
          httpClient: httpClientAdapterMock,
          urlInjector: urlInjectorMock,
        ),
        listFeedUrl = '/apiv3/tips',
        singleFeedUrl = '/apiv3/tips/details',
      });

  group('[Feed Repository]', () {
    test('Should return a list with Feed Entities', () async {
      when(() => urlInjectorMock.getEndPoint(
          package: 'feed', endpoint: 'listFeed')).thenReturn(listFeedUrl);
      when(() => httpClientAdapterMock.get(path: listFeedUrl)).thenAnswer(
          (_) async => (data: rawFeedListJsonMock, statusCode: 200));

      final result = await feedRepositoryInterface.getFeed();
      expect(result, isA<List<FeedEntity>>());
    });

    test('Should list a single entity', () async {
      final feedId = faker.randomGenerator.integer(100);
      when(() => urlInjectorMock.getEndPoint(
          package: 'feed',
          endpoint: 'singleFeedDetail')).thenReturn(singleFeedUrl);
      when(() => httpClientAdapterMock
              .get(path: singleFeedUrl, queryParameters: {'tip_id': feedId}))
          .thenAnswer(
              (_) async => (data: rawSingleFeedJsonMock, statusCode: 200));

      final result = await feedRepositoryInterface.getSingleFeed(feedId);

      verify(() => httpClientAdapterMock.get(
          path: singleFeedUrl, queryParameters: {'tip_id': feedId})).called(1);
      expect(result, isA<FeedEntity>());
    });
  });
}
