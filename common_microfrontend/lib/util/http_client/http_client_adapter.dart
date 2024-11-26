import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;

abstract class HttpClientInterface {
  Future<({dynamic data, int? statusCode})> get(
      {required String path,
      Map<String, dynamic>? extra,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters});

  Future<({dynamic data, int? statusCode})> post(
      {required String path,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? extra,
      required Map<String, dynamic>? data});

  Future<({dynamic data, int? statusCode})> put(
      {required String path,
      Map<String, dynamic>? extra,
      required Map<String, dynamic>? headers,
      required Map<String, dynamic>? data});

  Future<({dynamic data, int? statusCode})> delete(
      {required String path,
      Map<String, dynamic>? extra,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? data});
}

class DioAdapter implements HttpClientInterface {
  DioAdapter({required this.dio, List<Interceptor>? interceptors}) {
    if (interceptors != null) {
      dio.interceptors.addAll(interceptors);
    }
  }
  final Dio dio;
  ProgressCallback? progressCallback;
  CancelToken? cancelToken;

  @override
  Future<({dynamic data, int? statusCode})> get({
    required String path,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response result = await dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
        extra: extra,
      ),
    );
    return (data: result.data, statusCode: result.statusCode);
  }

  @override
  Future<({dynamic data, int? statusCode})> post({
    required String path,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    required Map<String, dynamic>? data,
  }) async {
    Response result = await dio.post(
      path,
      data: data,
      options: Options(
        headers: headers,
        extra: extra,
      ),
    );
    return (data: result.data, statusCode: result.statusCode);
  }

  @override
  Future<({dynamic data, int? statusCode})> put(
      {required String path,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? extra,
      required Map<String, dynamic>? data}) async {
    Response result = await dio.put(path,
        data: data, options: Options(headers: headers, extra: extra));
    return (data: result.data, statusCode: result.statusCode);
  }

  @override
  Future<({dynamic data, int? statusCode})> delete(
      {required String path,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? extra,
      Map<String, dynamic>? data}) async {
    Response result = await dio.delete(path,
        data: data, options: Options(headers: headers, extra: extra));
    return (data: result.data, statusCode: result.statusCode);
  }

  @visibleForTesting
  get interceptorList => dio.interceptors;
}

// Existe algum problema no método do Download do Dio quando ele é usado como Singleton, por isso foi criado essa nova
// classe, para que quando for necessário ela ser usada.

abstract class HttpClientDownloadInterface {
  Future<void> download(
      {required String url,
      required String downloadPath,
      required bool skipAuthTokenInterceptor,
      void Function(int, int)? onReceiveProgress});
}

class DioDownloadAdappter implements HttpClientDownloadInterface {
  DioDownloadAdappter({required this.dio});
  final Dio dio;

  @override
  Future<void> download(
      {required String url,
      required String downloadPath,
      required bool skipAuthTokenInterceptor,
      void Function(int, int)? onReceiveProgress}) async {
    await dio.download(
      url,
      downloadPath,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @visibleForTesting
  get interceptorList => dio.interceptors;
}
