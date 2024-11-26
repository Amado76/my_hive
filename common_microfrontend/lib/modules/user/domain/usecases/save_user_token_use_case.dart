import 'package:common_microfrontend/modules/user/domain/repositories/auth_user_repository_interface.dart';

class SaveUserTokenUseCase {
  final AuthUserRepositoryInterface _authUserRepository;

  SaveUserTokenUseCase(this._authUserRepository);

  Future<void> call(String token) async {
    await _authUserRepository.save(accessToken: token);
  }
}
