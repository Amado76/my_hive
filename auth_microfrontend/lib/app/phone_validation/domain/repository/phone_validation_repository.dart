abstract class PhoneValidationRepositoryInterface {
  Future<String> verifyPhoneWithCode(
      {required String phoneNumber,
      required String token,
      required String dialCode});
}
