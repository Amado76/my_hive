import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/modules/user/data/dtos/user_me_dto.dart';

void main() {
  group('UserMeDTO', () {
    // Dados de teste
    final Map<String, dynamic> testData = {
      'formatted_name': 'John Doe',
      'cpf': '123.456.789-09',
      'birthdate': '1980-01-01',
      'picture': 'http://example.com/image.jpg',
      'last_community_name': 'Elite Group',
      'name_profile': 'Advanced',
      'last_community_id': 10,
      'room_id': 40,
      'email': 'john.doe@example.com',
    };

    // Teste para fromMap
    test('should create an instance from map', () {
      var dto = UserMeDTO.fromMap(testData);
      expect(dto.formatted_name, equals('John Doe'));
      expect(dto.email, equals('john.doe@example.com'));
    });

    // Teste para toJson
    test('should convert to json string correctly', () {
      var dto = UserMeDTO.fromMap(testData);
      String json = dto.toJson();
      expect(json, isA<String>());
      expect(json, contains('"formatted_name":"John Doe"'));
    });

    // Teste para fromJson
    test('should create an instance from json string', () {
      String jsonStr =
          '{"formatted_name":"John Doe","cpf":"123.456.789-09","birthdate":"1980-01-01","picture":"http://example.com/image.jpg","last_community_name":"Elite Group","name_profile":"Advanced","last_community_id":10,"room_id":40,"email":"john.doe@example.com",}';
      var dto = UserMeDTO.fromJson(jsonStr);
      expect(dto.formatted_name, equals('John Doe'));
    });
  });
}
