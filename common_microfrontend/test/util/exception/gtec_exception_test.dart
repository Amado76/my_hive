import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/util/exception/gtec_exception.dart';

void main() {
  test('should create a new instance of GTecException', () {
    // Arrange
    final exception = GTecException(message: 'Test');

    // Assert
    expect(exception, isA<GTecException>());
  });
}
