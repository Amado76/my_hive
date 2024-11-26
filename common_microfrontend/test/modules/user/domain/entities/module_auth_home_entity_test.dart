import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/modules/user/data/dtos/module_auth_home_dto.dart';
import 'package:common_microfrontend/modules/user/domain/entities/module_auth_home_entity.dart';

void main() {
  group('ModuleAuthHomeEntity', () {
    // Dados de teste
    final testData = {
      'id': 2,
      'name': 'Home Dashboard',
      'appRoute': '/home',
      'iconLib': 'material',
      'iconName': 'home',
      'isAuthorized': true,
      'order': 1,
    };

    // Teste para fromMap
    test('should create an instance from map', () {
      var entity = ModuleAuthHomeEntity.fromMap(testData);
      expect(entity.id, equals(2));
      expect(entity.name, equals('Home Dashboard'));
      expect(entity.appRoute, equals('/home'));
      expect(entity.iconLib, equals('material'));
      expect(entity.iconName, equals('home'));
      expect(entity.isAuthorized, isTrue);
      expect(entity.order, equals(1));
    });

    // Teste para toJson
    test('should convert to json string correctly', () {
      var entity = ModuleAuthHomeEntity.fromMap(testData);
      String json = entity.toJson();
      expect(json, isA<String>());
      expect(json, contains('"name":"Home Dashboard"'));
    });

    // Teste para fromJson
    test('should create an instance from json string', () {
      String jsonStr =
          '{"id":2,"name":"Home Dashboard","appRoute":"/home","iconLib":"material","iconName":"home","isAuthorized":true,"order":1}';
      var entity = ModuleAuthHomeEntity.fromJson(jsonStr);
      expect(entity.id, equals(2));
      expect(entity.name, equals('Home Dashboard'));
      expect(entity.appRoute, equals('/home'));
      expect(entity.iconLib, equals('material'));
      expect(entity.iconName, equals('home'));
      expect(entity.isAuthorized, isTrue);
      expect(entity.order, equals(1));
    });

    // Teste para copyWith
    test('should copy correctly with modified values', () {
      var original = ModuleAuthHomeEntity.fromMap(testData);
      var copied = original.copyWith(name: 'New Home Dashboard');
      expect(copied.name, 'New Home Dashboard');
      expect(copied.id, original.id);
      expect(copied, isNot(equals(original)));
    });

    // Teste para fromDTO
    test('should convert from DTO correctly', () {
      var dto = const ModuleAuthHomeDTO(
          id: 2,
          name: 'Home Dashboard',
          app_route: '/home',
          icon_lib: 'material',
          icon_name: 'home',
          is_authorized: true,
          order: 1);
      var entity = ModuleAuthHomeEntity.fromDTO(dto);
      expect(entity.id, equals(2));
      expect(entity.name, equals('Home Dashboard'));
      expect(entity.appRoute, equals('/home'));
      expect(entity.iconLib, equals('material'));
      expect(entity.iconName, equals('home'));
      expect(entity.isAuthorized, isTrue);
      expect(entity.order, equals(1));
    });
  });
}
