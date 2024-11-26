import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/modules/user/data/dtos/user_profile_dto.dart';

void main() {
  group('UserProfileDTO', () {
    // Dados de teste
    final Map<String, dynamic> testData = {
      'first_name': 'John',
      'last_name': 'Doe',
      'formatted_name': 'John Doe',
      'phone_number': '1234567890',
      'email': 'john.doe@example.com',
      'cpf': '123.456.789-09',
      'nif': 'A12345678',
      'healthcare_plan': 'Premium Health',
      'reference_hospital': 'Central Hospital',
      'birthdate': '1980-01-01',
      'description': 'A brief description',
      'picture_url': 'http://example.com/image.jpg',
    };

    // Teste para fromMap
    test('should create an instance from map', () {
      var dto = UserProfileDTO.fromMap(testData);
      expect(dto.first_name, equals('John'));
      expect(dto.email, equals('john.doe@example.com'));
      expect(dto.phone_number, equals('1234567890'));
    });

    // Teste para toJson
    test('should convert to json string correctly', () {
      var dto = UserProfileDTO.fromMap(testData);
      String json = dto.toJson();
      expect(json, isA<String>());
      expect(json, contains('"email":"john.doe@example.com"'));
    });

    // Teste para fromJson
    test('should create an instance from json string', () {
      String jsonStr = json.encode(testData);
      var dto = UserProfileDTO.fromJson(jsonStr);
      expect(dto.formatted_name, equals('John Doe'));
      expect(dto.birthdate, equals('1980-01-01'));
    });
  });
}
