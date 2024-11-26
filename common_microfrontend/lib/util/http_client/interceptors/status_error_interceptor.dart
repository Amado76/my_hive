import 'package:common_microfrontend/util/exception/gtec_exception.dart';
import 'package:dio/dio.dart';

class StatusErrorInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, handler) {
    if (response.extra['skipStatusErrorInterceptor'] == true) {
      return handler.next(response);
    }
    var errorCode = response.data['status'];
    var errorMessage = response.data['msg'];

    if (errorCode == "0") {
      throw GTecException(message: errorMessage);
    }

    handler.next(response);
  }
}
