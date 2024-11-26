import 'package:my_profile_microfrontend/app/student/domain/dto/student_dto.dart';

class UpdateAccessDataDto extends StudentDto {
  static const pageId = 2;

  final String email;
  final String phoneNumber;
  final String? newPassword;
  final String? newPasswordConfirmation;

  UpdateAccessDataDto({
    required this.email,
    required this.phoneNumber,
    this.newPassword,
    this.newPasswordConfirmation,
  });

  @override
  Map<String, dynamic> toJson() {
    var jsonData = {
      'page_id': pageId,
      'email': email,
      'phone_number': phoneNumber,
      'new_password': newPassword,
      'new_password_confirmation': newPasswordConfirmation,
    };

    jsonData.removeWhere((_, value) => value == null);

    return jsonData;
  }

  bool get hasNewPassword =>
      (newPassword != null && newPassword!.isNotEmpty) &&
      (newPasswordConfirmation != null &&
          newPasswordConfirmation!.isNotEmpty) &&
      newPassword == newPasswordConfirmation;
}
