import 'package:auth_microfrontend/app/core/domain/repository/auth_repository_interface.dart';
import 'package:auth_microfrontend/app/core/domain/model/auth_phone_number.dart';

class LoginWithPhoneNumberUseCase {
  final AuthRepositoryInterface _authRepository;

  LoginWithPhoneNumberUseCase(this._authRepository);

  Future<String> call({required String phoneNumber, required password}) async {
    AuthPhoneNumber formattedPhoneNumber = phoneNumber;
    formattedPhoneNumber = formattedPhoneNumber.removeNonNumericCharacters();
    return _authRepository.loginWithPhoneNumber(
        phoneNumber: formattedPhoneNumber, password: password);
  }
}
