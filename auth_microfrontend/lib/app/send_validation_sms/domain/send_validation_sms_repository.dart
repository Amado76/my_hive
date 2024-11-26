abstract class SendValidationSmsRepositoryInterface {
  Future<String> sendVerificationCodeToPhone(
      {required String phoneNumber, required String dialCode});
}
