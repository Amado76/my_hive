class GTecException implements Exception {
  GTecException({required this.message, this.statusCode});
  final String message;
  final int? statusCode;
}
