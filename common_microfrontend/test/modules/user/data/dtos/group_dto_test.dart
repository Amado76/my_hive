import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/modules/user/data/dtos/group_dto.dart';

void main() {
  group('GroupDTO', () {
    // Teste para verificar se GroupDTO.fromMap constrói o objeto corretamente.
    test('should create an instance from map', () {
      Map<String, dynamic> data = {
        'name': 'Test Group',
        'name_profile': 'Test Profile',
        'community_id': 123,
        'logo_url': 'http://example.com/logo.png',
        'room_id': 678,
        'room': 'Room 1'
      };
      var group = GroupDTO.fromMap(data);

      expect(group.name, equals('Test Group'));
      expect(group.name_profile, equals('Test Profile'));
      expect(group.community_id, equals(123));
      expect(group.logo_url, equals('http://example.com/logo.png'));
      expect(group.room_id, equals(678));
      expect(group.room, equals('Room 1'));
    });

    // Teste para verificar se a conversão de um objeto para Map é correta.
    test('should convert to map correctly', () {
      var group = const GroupDTO(
          dependent_id: null,
          dependent: null,
          name: 'Test Group',
          name_profile: 'Test Profile',
          community_id: 123,
          logo_url: 'http://example.com/logo.png',
          room_id: 678,
          room: 'Room 1');
      Map<String, dynamic> data = group.toMap();

      expect(data['name'], equals('Test Group'));
      expect(data['name_profile'], equals('Test Profile'));
      expect(data['community_id'], equals(123));
      expect(data['logo_url'], equals('http://example.com/logo.png'));
      expect(data['room_id'], equals(678));
      expect(data['room'], equals('Room 1'));
    });

    // Teste para verificar se GroupDTO.fromJson e GroupDTO.toJson funcionam corretamente.
    test('should serialize and deserialize correctly', () {
      String json =
          '{"name":"Test Group","name_profile":"Test Profile","community_id":123,"logo_url":"http://example.com/logo.png","room_id":678,"room":"Room 1"}';
      var group = GroupDTO.fromJson(json);
      String serialized = group.toJson();

      expect(serialized, equals(json));
    });
  });

  test('should convert a list of maps to a list of GroupDTO objects', () {
    List<Map<String, dynamic>> mapList = [
      {
        'name': 'Group One',
        'name_profile': 'Profile One',
        'community_id': 1,
        'logo_url': 'http://example.com/logo1.png',
        'room_id': 201,
        'room': 'Court 1',
        'dependent_id': null,
        'dependent': null
      },
      {
        'name': 'Group Two',
        'name_profile': 'Profile Two',
        'community_id': 2,
        'logo_url': 'http://example.com/logo2.png',
        'room_id': 202,
        'room': 'Court 2',
        'dependent_id': null,
        'dependent': null
      }
    ];

    var groups = GroupDTO.fromMapList(mapList);

    expect(groups.length, equals(2));
    expect(groups[0].name, equals('Group One'));
    expect(groups[1].name, equals('Group Two'));
  });
}
