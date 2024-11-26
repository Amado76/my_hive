import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/modules/user/data/dtos/group_dto.dart';
import 'package:common_microfrontend/modules/user/domain/entities/group_entity.dart';

void main() {
  group('GroupEntity', () {
    // Dados de teste
    final testMap = {
      'name': 'Team A',
      'nameProfile': 'Profile A',
      'communityId': 1,
      'logoUrl': 'http://example.com/logoA.png',
      'roomId': 501,
      'room': 'Field 1'
    };

    const String jsonStr = '''
    {
      "name": "Team A",
      "nameProfile": "Profile A",
      "communityId": 1,
      "logoUrl": "http://example.com/logoA.png",
      "roomId": 501,
      "room": "Field 1"
    }''';

    // Teste para fromMap
    test('should create an instance from map', () {
      var entity = GroupEntity.fromMap(testMap);
      expect(entity.name, equals('Team A'));
      expect(entity.nameProfile, equals('Profile A'));
      expect(entity.communityId, equals(1));
      expect(entity.logoUrl, equals('http://example.com/logoA.png'));
      expect(entity.roomId, equals(501));
      expect(entity.room, equals('Field 1'));
    });

    // Teste para toJson
    test('should convert to json string correctly', () {
      var entity = GroupEntity.fromMap(testMap);
      String json = entity.toJson();
      expect(json, isA<String>());
      expect(json, contains('"name":"Team A"'));
    });

    // Teste para copyWith
    test('should copy correctly with modified values', () {
      var original = GroupEntity.fromMap(testMap);
      var copied = original.copyWith(name: 'Team B');
      expect(copied.name, 'Team B');
      expect(copied, isNot(equals(original)));
    });

    // Teste para fromDTO
    test('should convert from DTO correctly', () {
      var dto = const GroupDTO(
          name: 'Team A',
          name_profile: 'Profile A',
          community_id: 1,
          logo_url: 'http://example.com/logoA.png',
          room_id: 501,
          room: 'Field 1',
          dependent_id: null,
          dependent: null);
      var entity = GroupEntity.fromDTO(dto);
      expect(entity.name, equals('Team A'));
    });

    // Teste para fromJson
    test('should create an instance from json string', () {
      var entity = GroupEntity.fromJson(jsonStr);
      expect(entity.name, equals('Team A'));
      expect(entity.nameProfile, equals('Profile A'));
      expect(entity.communityId, equals(1));
      expect(entity.logoUrl, equals('http://example.com/logoA.png'));
      expect(entity.roomId, equals(501));
      expect(entity.room, equals('Field 1'));
    });
  });
}
