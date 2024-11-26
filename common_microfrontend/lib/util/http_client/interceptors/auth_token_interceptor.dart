import 'package:common_microfrontend/util/general_config/general_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthTokenInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.extra['skipAuthTokenInterceptor'] == true) {
      return handler.next(options);
    }

    String? token = Modular.get<GeneralConfig>().authUserEntity?.accessToken;

    options.headers.addAll({"Authorization": "JWT $token"});
    return handler.next(options);
  }
}
