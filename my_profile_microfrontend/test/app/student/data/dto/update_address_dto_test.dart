import 'package:flutter_test/flutter_test.dart';
import 'package:my_profile_microfrontend/app/student/data/dto/update_address_dto.dart';

import '../../../../util/mocks/dto_mocks.dart';

void main() {
  group('[Update Address DTO]', () {
    test('Should export DTO to JSON', () {
      final dto = updateAddressDtoMock;
      final json = dto.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['tipo_logradouro'], dto.streetType);
      expect(json['logradouro'], dto.street);
      expect(json['address_number'], dto.number);
      expect(json['complement'], dto.complement);
      expect(json['neighborhood'], dto.district);
      expect(json['cep'], dto.postalCode);
      expect(json['city'], dto.city);
      expect(json['state'], dto.state);
    });

    test('Should remove null values from JSON', () {
      final dto = updateAddressDtoMock;
      final json = dto.toJson();

      expect(json, isNot(containsValue(null)));
    });

    test('Should have a page ID', () {
      expect(UpdateAddressDto.pageId, 3);
    });
  });
}
