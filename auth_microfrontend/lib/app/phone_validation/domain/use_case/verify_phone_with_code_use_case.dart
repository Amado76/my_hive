import 'package:auth_microfrontend/app/core/domain/model/auth_phone_number.dart';
import 'package:auth_microfrontend/app/phone_validation/domain/repository/phone_validation_repository.dart';

class VerifyPhoneWithCodeUseCase {
  final PhoneValidationRepositoryInterface _repository;

  VerifyPhoneWithCodeUseCase(this._repository);

  Future<String> call(
      {required String phoneNumber,
      required String token,
      required String dialCode}) async {
    AuthPhoneNumber formattedPhoneNumber = phoneNumber;
    formattedPhoneNumber.removeNonNumericCharacters();
    return await _repository.verifyPhoneWithCode(
        phoneNumber: formattedPhoneNumber, token: token, dialCode: dialCode);
  }
}
