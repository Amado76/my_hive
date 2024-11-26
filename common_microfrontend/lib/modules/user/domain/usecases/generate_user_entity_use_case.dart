import 'dart:async';

import 'package:common_microfrontend/modules/user/domain/entities/group_entity.dart';
import 'package:common_microfrontend/modules/user/domain/entities/user_entity.dart';
import 'package:common_microfrontend/modules/user/domain/repositories/group_repository_interface.dart';
import 'package:common_microfrontend/modules/user/domain/repositories/module_auth_repository_interface.dart';
import 'package:common_microfrontend/modules/user/domain/repositories/user_repository_interface.dart';

class GenerateUserEntityUseCase {
  final GroupRepositoryInterface _groupRepository;
  final UserRepositoryInterface _userRepositoryImpl;
  final ModuleAuthRepositoryInterface _moduleAuthRepository;

  final StreamController<UserEntity> _userStreamController =
      StreamController<UserEntity>.broadcast();

  Stream<UserEntity> get userEntityStream =>
      _userStreamController.stream.asBroadcastStream();

  GenerateUserEntityUseCase(
    this._groupRepository,
    this._userRepositoryImpl,
    this._moduleAuthRepository,
  );

  Future<UserEntity> call() async {
    final groups = await _groupRepository.getGroup();
    final modulesHome = await _moduleAuthRepository.getModuleAuthHome();
    final modulesDrawer = await _moduleAuthRepository.getModuleAuthDrawer();
    final user = await _userRepositoryImpl.getUser();

    user.groups = groups as List<GroupEntity>;
    user.modulesAuthHome = modulesHome;
    user.modulesAuthDrawer = modulesDrawer;

    _userStreamController.sink.add(user);
    return user;
  }
}
