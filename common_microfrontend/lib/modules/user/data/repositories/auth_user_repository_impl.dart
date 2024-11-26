import 'dart:async';

import 'package:common_microfrontend/modules/user/domain/entities/auth_user_entity.dart';
import 'package:common_microfrontend/modules/user/domain/repositories/auth_user_repository_interface.dart';
import 'package:common_microfrontend/util/exception/gtec_exception.dart';
import 'package:common_microfrontend/util/secure_local_storage/secure_local_storage_adapter.dart';

class AuthUserRepositoryImpl implements AuthUserRepositoryInterface {
  AuthUserRepositoryImpl({
    required SecureLocalStorageInterface localStorage,
  }) : _localStorage = localStorage;

  final SecureLocalStorageInterface _localStorage;
  final StreamController<AuthUserEntity> _authTokenController =
      StreamController<AuthUserEntity>.broadcast();

  @override
  Stream<AuthUserEntity> get authTokenStream =>
      _authTokenController.stream.asBroadcastStream();
  @override
  StreamController<AuthUserEntity> get authTokenController =>
      _authTokenController;

  @override
  Future<void> save({required String accessToken}) async {
    await _localStorage.save(key: 'accessToken', value: accessToken);
    var entity = AuthUserEntity(accessToken: accessToken);
    _authTokenController.sink.add(entity);
  }

  @override
  Future<void> delete() async {
    AuthUserEntity? userEntity = await retrieve();

    if (userEntity == null) {
      throw GTecException(
          message: 'Você não pode deletar um token que não existe.');
    }

    await _localStorage.delete(key: 'accessToken');
    // _authTokenController.sink.add(const AuthUserEntity(accessToken: null));
    _authTokenController.sink.add(const AuthUserEntity(accessToken: null));
  }

  @override
  Future<AuthUserEntity?> retrieve() async {
    String? accessToken = await _localStorage.get(key: 'accessToken');

    return accessToken != null
        ? AuthUserEntity(accessToken: accessToken)
        : null;
  }

  @override
  void dispose() {
    _authTokenController.close();
  }
}
