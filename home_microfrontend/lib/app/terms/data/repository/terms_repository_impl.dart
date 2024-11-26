import 'package:common_microfrontend/util/http_client/http_client_adapter.dart';
import 'package:common_microfrontend/util/url_injector/url_injector.dart';
import 'package:home_microfrontend/app/terms/domain/repository/terms_repository_interface.dart';

class TermsRepositoryImpl implements TermsRepositoryInterface {
  final HttpClientInterface _httpClient;
  final UrlInjector _urlInjector;

  TermsRepositoryImpl({
    required HttpClientInterface httpClient,
    required UrlInjector urlInjector,
  })  : _httpClient = httpClient,
        _urlInjector = urlInjector;

  @override
  Future<String> getTerms() async {
    final url = _urlInjector.getEndPoint(endpoint: 'getTerms', package: 'home');
    final response = await _httpClient.get(path: url);
    return response.data['data']['terms'];
  }

  @override
  Future<void> acceptTerms() async {
    final url =
        _urlInjector.getEndPoint(endpoint: 'acceptTerms', package: 'home');
    await _httpClient.get(path: url);
  }

  @override
  Future<bool> userAcceptedLatestTerms() async {
    final url =
        _urlInjector.getEndPoint(endpoint: 'verifyTerms', package: 'home');
    final response = await _httpClient.get(path: url);
    return response.data['data']['valid'];
  }
}
