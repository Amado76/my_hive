import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/modules/user/data/dtos/module_auth_drawer_dto.dart';
import 'package:common_microfrontend/modules/user/domain/entities/module_auth_drawer_entity.dart';

void main() {
  group('ModuleAuthDrawerEntity', () {
    // Dados de teste
    final testData = {
      'id': 1,
      'name': 'User Settings',
      'appRoute': '/settings',
      'iconLib': 'material',
      'iconName': 'settings',
      'isAuthorized': true,
      'order': 10,
    };

    // Teste para fromMap
    test('should create an instance from map', () {
      var entity = ModuleAuthDrawerEntity.fromMap(testData);
      expect(entity.id, equals(1));
      expect(entity.name, equals('User Settings'));
      expect(entity.appRoute, equals('/settings'));
      expect(entity.iconLib, equals('material'));
      expect(entity.iconName, equals('settings'));
      expect(entity.isAuthorized, isTrue);
      expect(entity.order, equals(10));
    });

    // Teste para toJson
    test('should convert to json string correctly', () {
      var entity = ModuleAuthDrawerEntity.fromMap(testData);
      String json = entity.toJson();
      expect(json, isA<String>());
      expect(json, contains('"name":"User Settings"'));
    });

    // Teste para fromJson
    test('should create an instance from json string', () {
      String jsonStr =
          '{"id":1,"name":"User Settings","appRoute":"/settings","iconLib":"material","iconName":"settings","isAuthorized":true,"order":10}';
      var entity = ModuleAuthDrawerEntity.fromJson(jsonStr);
      expect(entity.id, equals(1));
      expect(entity.name, equals('User Settings'));
      expect(entity.appRoute, equals('/settings'));
      expect(entity.iconLib, equals('material'));
      expect(entity.iconName, equals('settings'));
      expect(entity.isAuthorized, isTrue);
      expect(entity.order, equals(10));
    });

    // Teste para copyWith
    test('should copy correctly with modified values', () {
      var original = ModuleAuthDrawerEntity.fromMap(testData);
      var copied = original.copyWith(name: 'Admin Settings');
      expect(copied.name, 'Admin Settings');
      expect(copied.id, original.id);
      expect(copied, isNot(equals(original)));
    });

    // Teste para fromDTO
    test('should convert from DTO correctly', () {
      var dto = const ModuleAuthDrawerDTO(
          id: 1,
          name: 'User Settings',
          app_route: '/settings',
          icon_lib: 'material',
          icon_name: 'settings',
          is_authorized: true,
          order: 10);
      var entity = ModuleAuthDrawerEntity.fromDTO(dto);
      expect(entity.id, equals(1));
      expect(entity.name, equals('User Settings'));
      expect(entity.appRoute, equals('/settings'));
      expect(entity.iconLib, equals('material'));
      expect(entity.iconName, equals('settings'));
      expect(entity.isAuthorized, isTrue);
      expect(entity.order, equals(10));
    });
  });
}
