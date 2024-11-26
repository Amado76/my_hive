import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/modules/user/data/dtos/user_me_dto.dart';
import 'package:common_microfrontend/modules/user/data/dtos/user_profile_dto.dart';
import 'package:common_microfrontend/modules/user/domain/entities/user_entity.dart';

void main() {
  group('UserEntity', () {
    // Dados de teste
    final testData = {
      'firstName': 'John',
      'lastName': 'Doe',
      'fullName': 'John Doe',
      'phoneNumber': '1234567890',
      'email': 'john.doe@example.com',
      'cpf': '123.456.789-09',
      'birthdate': '1980-01-01',
      'description': 'A brief description',
      'pictureUrl': 'http://example.com/image.jpg',
      'lastCommunityName': 'Elite Group',
      'nameProfile': 'Advanced',
      'lastCommunityId': 10,
      'roomId': 40,
      'groups': [],
      'modulesAuthHome': [],
      'modulesAuthDrawer': [],
    };

    // Teste para fromMap
    test('should create an instance from map', () {
      var user = UserEntity.fromMap(testData);
      expect(user.firstName, equals('John'));
      expect(user.email, equals('john.doe@example.com'));
    });

    // Teste para toJson
    test('should convert to json string correctly', () {
      var user = UserEntity.fromMap(testData);
      String json = user.toJson();
      expect(json, isA<String>());
      expect(json, contains('"firstName":"John"'));
    });

    // Teste para fromJson
    test('should create an instance from json string', () {
      String jsonStr = json.encode(testData);
      var user = UserEntity.fromJson(jsonStr);
      expect(user.firstName, equals('John'));
    });

    // Teste para copyWith
    test('should copy correctly with modified values', () {
      var original = UserEntity.fromMap(testData);
      var copied = original.copyWith(firstName: 'Jane');
      expect(copied.firstName, 'Jane');
      expect(copied.lastName, original.lastName);
    });

    // Teste para fromUserMeDTO
    test('should convert from UserMeDTO correctly', () {
      var dto = const UserMeDTO(
        formatted_name: 'John Doe',
        email: 'john.doe@example.com',
        cpf: '123.456.789-09',
        birthdate: '1980-01-01',
        last_community_name: 'Elite Group',
        name_profile: 'Advanced',
        last_community_id: 10,
        room_id: 40,
        user_id: 0,
        picture: 'http://example.com/image.jpg',
        description: 'A brief description',
        first_name: 'John',
        last_name: 'Doe',
        phone_number: '1234567890',
        picture_url: 'http://example.com/image.jpg',
      );
      var user = UserEntity.fromUserMeDTO(dto);
      expect(user.email, equals('john.doe@example.com'));
      expect(user.cpf, equals('123.456.789-09'));
    });

    // Teste para fromUserProfileDTO
    test('should convert from UserProfileDTO correctly', () {
      var userProfileDTO = UserProfileDTO(
        email: '',
        cpf: '',
        birthdate: '',
        last_community_name: '',
        picture_url: '',
        first_name: 'John',
        last_name: 'Doe',
        formatted_name: 'John Doe',
        phone_number: '1234567890',
        description: 'A brief description',
      );
      var user = UserEntity.fromUserProfileDTO(userProfileDTO);
      expect(user.firstName, equals('John'));
      expect(user.description, equals('A brief description'));
    });

    // Teste para combine
    test('should combine two UserEntity instances correctly', () {
      var user1 = UserEntity.fromMap(testData);
      var user2 = UserEntity.fromMap({
        ...testData,
        'firstName': 'Jane',
        'lastName': 'Smith',
        'email': 'jane.smith@example.com',
        'phoneNumber': '0987654321',
      });
      var combined = UserEntity.combine(user1, user2);
      expect(combined.firstName, equals('John'));
      expect(combined.email, equals('john.doe@example.com'));
      expect(combined.lastName, equals('Doe'));
      expect(combined.phoneNumber, equals('1234567890'));
    });
  });
}
