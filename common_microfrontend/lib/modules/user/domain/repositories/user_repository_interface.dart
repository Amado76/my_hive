import 'package:common_microfrontend/modules/user/domain/entities/user_entity.dart';

abstract class UserRepositoryInterface {
  Future<UserEntity> getUser();
}
