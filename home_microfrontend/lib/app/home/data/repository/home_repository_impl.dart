import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:home_microfrontend/app/home/data/dto/home_data_dto.dart';
import 'package:home_microfrontend/app/home/domain/repository/home_repository_interface.dart';

class HomeRepositoryImpl implements HomeRepositoryInterface {
  final HttpClientInterface _httpClient;
  final UrlInjector _urlInjector;

  HomeRepositoryImpl({
    required HttpClientInterface httpClient,
    required UrlInjector urlInjector,
  })  : _httpClient = httpClient,
        _urlInjector = urlInjector;

  @override
  Future<HomeDataDto> getHomeData() async {
    final url =
        _urlInjector.getEndPoint(endpoint: 'getHomeData', package: 'home');
    final response = await _httpClient.get(path: url);
    return HomeDataDto.fromJson(response.data);
  }

  @override
  Future<bool> hasCommunicationNotifications() async {
    final url = _urlInjector.getEndPoint(
        endpoint: 'hasCommunicationNotifications', package: 'home');
    final response = await _httpClient.get(path: url);
    bool hasCommunicationNotificaions =
        response.data['data']['has_pending_notifications'];
    return hasCommunicationNotificaions;
  }
}
