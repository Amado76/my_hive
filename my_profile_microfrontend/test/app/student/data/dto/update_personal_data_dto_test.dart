import 'package:flutter_test/flutter_test.dart';
import 'package:my_profile_microfrontend/app/student/data/dto/update_personal_data_dto.dart';

import '../../../../util/mocks/dto_mocks.dart';

void main() {
  group('[Update Personal Data DTO]', () {
    test('Should export DTO to JSON', () {
      final dto = updatePersonalDataDtoMock;
      final json = dto.toJson();
      expect(json, isA<Map<String, dynamic>>());
      expect(json['first_name'], dto.firstName);
      expect(json['last_name'], dto.lastName);
      expect(json['birthdate'], dto.birthdate);
      expect(json['gender'], dto.gender);
      expect(json['height'], dto.height);
      expect(json['weight'], dto.weight);
      expect(json['foot'], dto.dominantSide);
      expect(json['healthcare_plan'], dto.healthCarePlan);
      expect(json['reference_hospital'], dto.referenceHospital);
      expect(json['picture'], dto.avatar);
    });

    test('Should remove null values from JSON', () {
      final dto = updatePersonalDataDtoMock;
      final json = dto.toJson();

      expect(json, isNot(containsValue(null)));
    });

    test('Should have a page ID', () {
      expect(UpdatePersonalDataDto.pageId, 1);
    });
  });
}
