import 'package:auth_microfrontend/app/core/domain/model/auth_phone_number.dart';
import 'package:auth_microfrontend/app/send_validation_sms/domain/send_validation_sms_repository.dart';

class SendVerificationCodeToPhoneUseCase {
  final SendValidationSmsRepositoryInterface _repository;

  SendVerificationCodeToPhoneUseCase(this._repository);

  Future<String> call(
      {required String phoneNumber, required String dialCode}) async {
    AuthPhoneNumber formattedPhoneNumber = phoneNumber;

    formattedPhoneNumber.removeNonNumericCharacters();
    return await _repository.sendVerificationCodeToPhone(
        phoneNumber: formattedPhoneNumber, dialCode: dialCode);
  }
}
