import 'package:auth_microfrontend/app/core/domain/model/auth_phone_number.dart';
import 'package:auth_microfrontend/app/send_validation_sms/domain/send_validation_sms_repository.dart';
import 'package:common_microfrontend/util/http_client/http_client_adapter.dart';
import 'package:common_microfrontend/util/url_injector/url_injector.dart';

class SendValidationSmsRepositoryImpl
    implements SendValidationSmsRepositoryInterface {
  final HttpClientInterface _httpClient;
  final UrlInjector _urlInjector;

  SendValidationSmsRepositoryImpl(
      HttpClientInterface httpClient, UrlInjector urlInjector)
      : _httpClient = httpClient,
        _urlInjector = urlInjector;
  @override
  Future<String> sendVerificationCodeToPhone(
      {required AuthPhoneNumber phoneNumber, required String dialCode}) async {
    final url = _urlInjector.getEndPoint(
      endpoint: 'sendValidationSMS',
      package: 'authentication',
    );
    final response = await _httpClient.post(
      path: url,
      extra: {"skipAuthTokenInterceptor": true},
      data: {"phone_number": phoneNumber, "ddi": dialCode},
    );
    return response.data['msg'];
  }
}
