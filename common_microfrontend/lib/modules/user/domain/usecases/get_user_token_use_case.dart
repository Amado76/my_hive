import 'package:common_microfrontend/modules/user/domain/entities/auth_user_entity.dart';
import 'package:common_microfrontend/modules/user/domain/repositories/auth_user_repository_interface.dart';

class GetUserTokenUseCase {
  final AuthUserRepositoryInterface _authUserRepository;

  GetUserTokenUseCase(this._authUserRepository);

  Future<AuthUserEntity?> call() async {
    return await _authUserRepository.retrieve();
  }
}
