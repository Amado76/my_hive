import 'package:flutter_test/flutter_test.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/my_profile_entity.dart';

import '../../../../util/mocks/response_mocks.dart';

void main() {
  group('[MyProfileEntity]', () {
    test('Should retrieve data with toJson', () async {
      var jsonData = MyProfileEntity.fromJson(getProfileDataMock['data']);

      expect(jsonData, isA<MyProfileEntity>());
    });

    test('formattedHeight getter', () {
      var jsonData = MyProfileEntity.fromJson(getProfileDataMock['data']);

      expect(jsonData.formattedHeight, '1,70');
    });

    test('formattedWeight getter', () {
      var jsonData = MyProfileEntity.fromJson(getProfileDataMock['data']);

      expect(jsonData.formattedWeight, '70,5');
    });

    test('formattedPhoneNumber getter', () {
      var wrongFormatNumberJson = {
        ...Map<String, dynamic>.from(getProfileDataMock['data']),
        'phone_number': '12345',
      };

      var jsonData = MyProfileEntity.fromJson(getProfileDataMock['data']);
      var jsonWrongData = MyProfileEntity.fromJson(wrongFormatNumberJson);

      expect(jsonData.formattedPhoneNumber, '11 99999-9999');
      expect(jsonWrongData.formattedPhoneNumber, '12345');
    });
  });
}
