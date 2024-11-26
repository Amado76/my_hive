import 'package:auth_microfrontend/app/core/domain/repository/auth_repository_interface.dart';

class ResetPasswordUseCase {
  final AuthRepositoryInterface _authRepository;

  ResetPasswordUseCase({required AuthRepositoryInterface authRepository})
      : _authRepository = authRepository;

  Future<String> call({required String email}) async {
    return _authRepository.resetPassword(email: email);
  }
}
