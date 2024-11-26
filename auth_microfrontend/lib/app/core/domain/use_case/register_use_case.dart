import 'dart:convert' show base64Encode;

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:auth_microfrontend/app/core/domain/repository/auth_repository_interface.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class RegisterUseCase {
  final AuthRepositoryInterface _authRepository;

  RegisterUseCase({required AuthRepositoryInterface authRepository})
      : _authRepository = authRepository;

  Future<String> call(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required String classCode,
      String? cpf,
      XFile? image}) async {
    final base64Image = await imageToBase64(image);
    final String authToken = await _authRepository.register(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      cpf: cpf,
      base64Image: base64Image,
      classCode: classCode,
    );
    return authToken;
  }

  @visibleForTesting
  Future<String?> imageToBase64(XFile? imageFile) async {
    if (imageFile == null) return null;
    final bytes = await XFile(imageFile.path).readAsBytes();
    String base64String = base64Encode(bytes);
    return base64String;
  }
}
