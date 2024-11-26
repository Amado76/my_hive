import 'package:my_profile_microfrontend/app/student/domain/dto/student_dto.dart';

class UpdatePersonalDataDto extends StudentDto {
  static const pageId = 1;

  final String firstName;
  final String lastName;
  final String? birthdate;
  final String? gender;
  final double? height;
  final double? weight;
  final String? dominantSide;
  final String? healthCarePlan;
  final String? referenceHospital;
  final String? avatar;

  UpdatePersonalDataDto({
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    required this.gender,
    required this.height,
    required this.weight,
    required this.dominantSide,
    required this.healthCarePlan,
    required this.referenceHospital,
    required this.avatar,
  });

  @override
  Map<String, dynamic> toJson() {
    var jsonData = {
      'page_id': pageId,
      'first_name': firstName,
      'last_name': lastName,
      'birthdate': birthdate,
      'gender': gender,
      'height': height,
      'weight': weight,
      'foot': dominantSide,
      'healthcare_plan': healthCarePlan,
      'reference_hospital': referenceHospital,
      'picture': avatar,
    };

    jsonData.removeWhere((_, value) => value == null);

    return jsonData;
  }
}
