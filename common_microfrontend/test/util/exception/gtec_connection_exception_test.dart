import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should create a new instance of CustomConnectionException', () {
    // Arrange
    final exception = CustomConnectionException(
        message: 'Test', requestOptions: RequestOptions(path: ''));

    // Assert
    expect(exception, isA<CustomConnectionException>());
  });
}
