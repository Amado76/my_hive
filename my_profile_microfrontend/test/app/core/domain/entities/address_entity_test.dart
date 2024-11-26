import 'package:flutter_test/flutter_test.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/address_entity.dart';

import '../../../../util/mocks/response_mocks.dart';

void main() {
  group('[AddressEntity]', () {
    test('Should retrieve data with fromJson', () async {
      var jsonData =
          AddressEntity.fromJson(getProfileDataMock['data']['address']);

      expect(jsonData, isA<AddressEntity>());
    });
  });
}
