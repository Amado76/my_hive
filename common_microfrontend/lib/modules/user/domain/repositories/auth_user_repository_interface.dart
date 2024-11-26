// ignore_for_file: unused_field

import 'dart:async';

import 'package:common_microfrontend/modules/user/domain/entities/auth_user_entity.dart';

abstract class AuthUserRepositoryInterface {
  late final StreamController<AuthUserEntity> _authTokenController;
  Stream<AuthUserEntity> get authTokenStream;
  StreamController<AuthUserEntity> get authTokenController;
  Future<void> save({required String accessToken});
  Future<void> delete();
  Future<AuthUserEntity?> retrieve();
  void dispose();
}
