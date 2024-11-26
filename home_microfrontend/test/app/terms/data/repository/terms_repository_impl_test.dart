import 'package:flutter_test/flutter_test.dart';
import 'package:home_microfrontend/app/terms/data/repository/terms_repository_impl.dart';
import 'package:home_microfrontend/app/terms/domain/repository/terms_repository_interface.dart';
import 'package:common_microfrontend/util/http_client/http_client_adapter.dart';
import 'package:common_microfrontend/util/url_injector/url_injector.dart';
import 'package:mocktail/mocktail.dart';

class UrlInjectorMock extends Mock implements UrlInjector {}

class HttpClientAdapterMock extends Mock implements DioAdapter {}

void main() {
  late HttpClientInterface httpClientAdapterMock;
  late UrlInjector urlInjectorMock;

  late TermsRepositoryInterface termsRepository;

  setUp(() => {
        httpClientAdapterMock = HttpClientAdapterMock(),
        urlInjectorMock = UrlInjectorMock(),
        termsRepository = TermsRepositoryImpl(
          httpClient: httpClientAdapterMock,
          urlInjector: urlInjectorMock,
        )
      });

  test('Should return a string with terms', () async {
    when(() =>
            urlInjectorMock.getEndPoint(endpoint: 'getTerms', package: 'home'))
        .thenReturn('/apiv3/sys/terms');
    when(() => httpClientAdapterMock.get(path: '/apiv3/sys/terms'))
        .thenAnswer((_) async => (data: termsJson, statusCode: 200));

    final result = await termsRepository.getTerms();

    expect(result, "Houve uma atualização nos termos de uso.");
  });

  test('Should accept terms', () async {
    when(() => urlInjectorMock.getEndPoint(
        endpoint: 'acceptTerms',
        package: 'home')).thenReturn('/apiv3/sys/user_terms_lgpd');
    when(() => httpClientAdapterMock.get(path: '/apiv3/sys/user_terms_lgpd'))
        .thenAnswer((_) async => (data: termsJson, statusCode: 200));

    await termsRepository.acceptTerms();
    verify(() => httpClientAdapterMock.get(path: '/apiv3/sys/user_terms_lgpd'));
  });

  test('Should return true if user accepted latest terms', () async {
    when(() => urlInjectorMock.getEndPoint(
        endpoint: 'verifyTerms',
        package: 'home')).thenReturn('/apiv3/sys/verify_terms_lgpd');
    when(() => httpClientAdapterMock.get(path: '/apiv3/sys/verify_terms_lgpd'))
        .thenAnswer((_) async => (
              data: {
                "data": {"valid": true},
                "status": 1
              },
              statusCode: 200
            ));

    final result = await termsRepository.userAcceptedLatestTerms();

    expect(result, true);
  });
}

final termsJson = {
  "status": "1",
  "msg": "",
  "details": "",
  "data": {"terms": "Houve uma atualização nos termos de uso."}
};
