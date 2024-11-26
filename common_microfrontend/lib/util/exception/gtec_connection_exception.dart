import 'package:dio/dio.dart';

class CustomConnectionException extends DioException {
  CustomConnectionException(
      {required this.message, this.statusCode, required super.requestOptions});
  @override
  // ignore: overridden_fields
  final String message;
  final int? statusCode;
}
