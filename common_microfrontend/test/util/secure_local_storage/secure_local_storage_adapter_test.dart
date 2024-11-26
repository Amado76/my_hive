import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  SecureLocalStorageInterface secureLocalStorageAdapter;

  secureLocalStorageAdapter = SecureLocalStorageAdapter(
      secureLocalStorage: const FlutterSecureStorage());

  group('[SecureStorageAdapter]', () {
    test('should read a string from local secure storage', () async {
      // Arrange
      FlutterSecureStorage.setMockInitialValues({'key_test': 'value_test'});
      // Act
      String? result = await secureLocalStorageAdapter.get(key: 'key_test');
      // Assert
      expect(result, 'value_test');
    });
    test('should write a string to a local secure storage', () async {
      // Arrange
      FlutterSecureStorage.setMockInitialValues({'key_test': 'value_test'});
      // Act
      await secureLocalStorageAdapter.save(
          key: 'key_test', value: 'new_value_test');
      String? result = await secureLocalStorageAdapter.get(key: 'key_test');
      // Assert
      expect(result, 'new_value_test');
    });
    test('should delete a string from local secure storage', () async {
      // Arrange
      FlutterSecureStorage.setMockInitialValues({'key_test': 'value_test'});
      // Act
      await secureLocalStorageAdapter.delete(key: 'key_test');
      String? result = await secureLocalStorageAdapter.get(key: 'key_test');
      // Assert
      expect(result, null);
    });
  });
}
