import 'package:auth_microfrontend/app/core/domain/model/auth_phone_number.dart';
import 'package:auth_microfrontend/app/phone_validation/domain/repository/phone_validation_repository.dart';
import 'package:common_microfrontend/util/http_client/http_client_adapter.dart';
import 'package:common_microfrontend/util/url_injector/url_injector.dart';

class PhoneValidationRepositoryImpl
    implements PhoneValidationRepositoryInterface {
  final HttpClientInterface _httpClient;
  final UrlInjector _urlInjector;

  PhoneValidationRepositoryImpl(this._httpClient, this._urlInjector);
  @override
  Future<String> verifyPhoneWithCode(
      {required AuthPhoneNumber phoneNumber,
      required String token,
      required dialCode}) async {
    final url = _urlInjector.getEndPoint(
      endpoint: 'verifyPhoneNumber',
      package: 'authentication',
    );
    final response = await _httpClient.post(
      path: url,
      extra: {"skipAuthTokenInterceptor": true},
      data: {'phone_number': phoneNumber, 'token': token, 'ddi': dialCode},
    );
    return response.data['msg'];
  }
}
