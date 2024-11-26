import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureLocalStorageInterface {
  Future<void> save({required String key, required String value});
  Future<String?> get({required String key});
  Future<void> delete({required String key});
}

class SecureLocalStorageAdapter implements SecureLocalStorageInterface {
  SecureLocalStorageAdapter({required this.secureLocalStorage});
  final FlutterSecureStorage secureLocalStorage;

  @override
  Future<void> save({required String key, required String value}) async {
    await secureLocalStorage.write(key: key, value: value);
  }

  @override
  Future<String?> get({required String key}) async {
    return await secureLocalStorage.read(key: key);
  }

  @override
  Future<void> delete({required String key}) async {
    await secureLocalStorage.delete(key: key);
  }
}
