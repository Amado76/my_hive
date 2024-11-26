import 'package:flutter_test/flutter_test.dart';
import 'package:my_profile_microfrontend/app/student/data/dto/update_documents_dto.dart';

import '../../../../util/mocks/dto_mocks.dart';

void main() {
  group('[Update Documents DTO]', () {
    test('Should export DTO to JSON', () {
      final dto = updateDocumentsDtoMock;
      final json = dto.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['cpf'], dto.cpf);
      expect(json['rg'], dto.rg);
      expect(json['nif'], dto.nif);
      expect(json['nis'], dto.nis);
      expect(json['birth_certificate'], dto.birthCertificate);
    });

    test('Should remove null values from JSON', () {
      final dto = updateDocumentsDtoMock;
      final json = dto.toJson();

      expect(json, isNot(containsValue(null)));
    });

    test('Should have a page ID', () {
      expect(UpdateDocumentsDto.pageId, 4);
    });
  });
}
