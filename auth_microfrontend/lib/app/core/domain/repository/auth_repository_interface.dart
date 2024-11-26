abstract class AuthRepositoryInterface {
  Future<String> loginWithPhoneNumber(
      {required String phoneNumber, required String password});

  Future<String> register(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required String classCode,
      String? cpf,
      String? base64Image});

  Future<String> resetPassword({required String email});
}
