import 'package:flutter_test/flutter_test.dart';
import 'package:my_profile_microfrontend/app/student/data/dto/update_access_data_dto.dart';

import '../../../../util/mocks/dto_mocks.dart';

void main() {
  group('[Update Access Data DTO]', () {
    test('Should export DTO to JSON', () {
      final dto = updateAccessDataDtoMock;
      final json = dto.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['email'], dto.email);
      expect(json['phone_number'], dto.phoneNumber);
      expect(json['new_password'], dto.newPassword);
      expect(json['new_password_confirmation'], dto.newPasswordConfirmation);
    });

    test('Should remove null values from JSON', () {
      final dto = updateAccessDataDtoMock;
      final json = dto.toJson();

      expect(json, isNot(containsValue(null)));
    });

    test('Should have a page ID', () {
      expect(UpdateAccessDataDto.pageId, 2);
    });
  });
}
