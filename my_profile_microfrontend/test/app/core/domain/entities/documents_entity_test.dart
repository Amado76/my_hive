import 'package:flutter_test/flutter_test.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/documents_entity.dart';

import '../../../../util/mocks/response_mocks.dart';

void main() {
  group('[DocumentsEntity]', () {
    test('Should retrieve data with fromJson', () async {
      var jsonData = DocumentsEntity.fromJson(getProfileDataMock['data']);

      expect(jsonData, isA<DocumentsEntity>());
    });
  });
}
