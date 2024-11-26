import 'package:common_microfrontend/util/exception/gtec_connection_exception.dart';
import 'package:common_microfrontend/util/exception/gtec_exception.dart';
import 'package:dio/dio.dart';

class DioExceptionInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    CustomConnectionException gTecConnectionException;
    GTecException gTecException;

    if (err.error is GTecException) {
      gTecException = err.error as GTecException;
      gTecConnectionException = CustomConnectionException(
        statusCode: gTecException.statusCode,
        message: gTecException.message,
        requestOptions: err.requestOptions,
      );
      throw gTecConnectionException;
    }
    if (err.response != null && err.response!.statusCode == 401) {
      gTecConnectionException = CustomConnectionException(
        statusCode: err.response!.statusCode,
        message: "unauthorized",
        requestOptions: err.requestOptions,
      );
      throw gTecConnectionException;
    }

    if (err.response != null && err.response!.statusCode == 401) {
      gTecConnectionException = CustomConnectionException(
        statusCode: err.response!.statusCode,
        message: "unauthorized",
        requestOptions: err.requestOptions,
      );
      throw gTecConnectionException;
    }

    if (err.response != null && err.response!.statusCode == 500) {
      gTecConnectionException = CustomConnectionException(
        statusCode: err.response!.statusCode,
        message: "internal-server-error",
        requestOptions: err.requestOptions,
      );
      throw gTecConnectionException;
    }
    if (err.response != null) {
      Map<String, dynamic> messageMap = err.response!.data;
      gTecConnectionException = CustomConnectionException(
        statusCode: err.response!.statusCode,
        message: messageMap.values.first[0],
        requestOptions: err.requestOptions,
      );
      throw gTecConnectionException;
    }
  }
}
