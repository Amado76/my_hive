import 'package:common_microfrontend/modules/user/domain/repositories/auth_user_repository_interface.dart';

class DeleteUserTokenUseCase {
  final AuthUserRepositoryInterface _userRepository;

  DeleteUserTokenUseCase(this._userRepository);

  Future<void> call() async {
    _userRepository.delete();
  }
}
