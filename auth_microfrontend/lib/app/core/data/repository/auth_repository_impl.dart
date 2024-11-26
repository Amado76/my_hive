import 'package:auth_microfrontend/app/core/domain/repository/auth_repository_interface.dart';
import 'package:common_microfrontend/util/http_client/http_client_adapter.dart';
import 'package:common_microfrontend/util/url_injector/url_injector.dart';

class AuthRepositoryImpl implements AuthRepositoryInterface {
  final HttpClientInterface _httpClient;
  final UrlInjector _urlInjector;

  AuthRepositoryImpl({
    required HttpClientInterface httpClient,
    required UrlInjector urlInjector,
  })  : _httpClient = httpClient,
        _urlInjector = urlInjector;

  @override
  Future<String> loginWithPhoneNumber(
      {required String phoneNumber, required String password}) async {
    final url = _urlInjector.getEndPoint(
      endpoint: 'login',
      package: 'authentication',
    );
    final response = await _httpClient.post(path: url, extra: {
      "skipAuthTokenInterceptor": true
    }, data: {
      "username": phoneNumber,
      "password": password,
    });
    return response.data['token'];
  }

  @override
  Future<String> register(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required String classCode,
      String? cpf,
      String? base64Image}) async {
    final url = _urlInjector.getEndPoint(
      endpoint: 'sign_up',
      package: 'authentication',
    );
    final response = await _httpClient.post(path: url, extra: {
      "skipAuthTokenInterceptor": true
    }, data: {
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phoneNumber,
      "email": email,
      "password": password,
      "cpf": cpf,
      "picture": base64Image,
      "code_room": classCode,
    });
    return response.data['auth_token'];
  }

  @override
  Future<String> resetPassword({required String email}) async {
    final url = _urlInjector.getEndPoint(
      endpoint: 'resetPassword',
      package: 'authentication',
    );
    final response = await _httpClient.post(path: url, extra: {
      "skipAuthTokenInterceptor": true
    }, data: {
      "email": email,
    });
    return response.data['msg'];
  }
}
