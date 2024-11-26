import 'package:flutter_test/flutter_test.dart';
import 'package:home_microfrontend/app/home/data/dto/home_data_dto.dart';
import 'package:home_microfrontend/app/home/data/repository/home_repository_impl.dart';
import 'package:home_microfrontend/app/home/domain/repository/home_repository_interface.dart';
import 'package:common_microfrontend/util/http_client/http_client_adapter.dart';
import 'package:common_microfrontend/util/url_injector/url_injector.dart';
import 'package:mocktail/mocktail.dart';

class UrlInjectorMock extends Mock implements UrlInjector {}

class HttpClientAdapterMock extends Mock implements DioAdapter {}

void main() {
  late HttpClientInterface httpClientAdapterMock;
  late UrlInjector urlInjectorMock;

  late HomeRepositoryInterface homeRepositoryInterface;

  setUp(() => {
        httpClientAdapterMock = HttpClientAdapterMock(),
        urlInjectorMock = UrlInjectorMock(),
        homeRepositoryInterface = HomeRepositoryImpl(
          httpClient: httpClientAdapterMock,
          urlInjector: urlInjectorMock,
        )
      });

  test('Should return a [HomeDataDto]', () async {
    when(() => urlInjectorMock.getEndPoint(
        endpoint: 'getHomeData',
        package: 'home')).thenReturn('/apiv3/user/home');
    when(() => httpClientAdapterMock.get(path: '/apiv3/user/home'))
        .thenAnswer((_) async => (data: jsonHomeData, statusCode: 200));

    final result = await homeRepositoryInterface.getHomeData();

    expect(result, isA<HomeDataDto>());
  });

  test('Should return a [bool] when hasCommunicationNotifications', () async {
    when(() => urlInjectorMock.getEndPoint(
        endpoint: 'hasCommunicationNotifications',
        package: 'home')).thenReturn('/apiv3/me/pending_notifications');

    when(() =>
            httpClientAdapterMock.get(path: '/apiv3/me/pending_notifications'))
        .thenAnswer((_) async => (
              data: {
                "data": {"has_pending_notifications": true}
              },
              statusCode: 200
            ));

    final result =
        await homeRepositoryInterface.hasCommunicationNotifications();

    expect(result, true);
  });
}

final jsonHomeData = {
  "status": "1",
  "msg": "",
  "details": "",
  "data": {
    "user_avatar": "",
    "community_logo": false,
    "banners": [
      {
        "url_image": "",
        "action": "page",
        "url": null,
        "id": 1379,
        "module": "home"
      },
      {
        "url_image": "teste",
        "action": "page",
        "url": null,
        "id": 1380,
        "module": "home"
      }
    ]
  }
};
