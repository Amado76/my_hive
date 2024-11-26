import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/modules/user/data/dtos/module_auth_home_dto.dart';
import 'package:common_microfrontend/modules/user/domain/entities/module_auth_home_entity.dart';

void main() {
  group('ModuleAuthHomeDTO', () {
    // Dados de teste
    final Map<String, dynamic> testData = {
      'id': 1,
      'name': 'Dashboard',
      'app_route': '/dashboard',
      'icon_lib': 'FontAwesome',
      'icon_name': 'fa-dashboard',
      'is_authorized': true,
      'order': 1,
    };

    // Teste para fromMap
    test('should create an instance from map', () {
      var dto = ModuleAuthHomeDTO.fromMap(testData);
      expect(dto.id, equals(1));
      expect(dto.name, equals('Dashboard'));
      expect(dto.app_route, equals('/dashboard'));
      expect(dto.icon_lib, equals('FontAwesome'));
      expect(dto.icon_name, equals('fa-dashboard'));
      expect(dto.is_authorized, isTrue);
      expect(dto.order, equals(1));
    });

    // Teste para toJson
    test('should convert to json string correctly', () {
      var dto = ModuleAuthHomeDTO.fromMap(testData);
      String json = dto.toJson();
      expect(json, isA<String>());
      expect(json, contains('"name":"Dashboard"'));
    });

    // Teste para fromJson
    test('should create an instance from json string', () {
      String jsonStr =
          '{"id":1,"name":"Dashboard","app_route":"/dashboard","icon_lib":"FontAwesome","icon_name":"fa-dashboard","is_authorized":true,"order":1}';
      var dto = ModuleAuthHomeDTO.fromJson(jsonStr);
      expect(dto.id, equals(1));
      expect(dto.name, equals('Dashboard'));
      expect(dto.app_route, equals('/dashboard'));
    });

    // Teste para toEntity
    test('should convert to entity correctly', () {
      var dto = ModuleAuthHomeDTO.fromMap(testData);
      var entity = dto.toEntity();
      expect(entity, isA<ModuleAuthHomeEntity>());
      expect(entity.name, equals('Dashboard'));
      expect(entity.appRoute, equals('/dashboard'));
      expect(entity.iconName, equals('fa-dashboard'));
    });

    // Teste para fromMapList
    test('should convert a list of maps to a list of ModuleAuthHomeDTO objects',
        () {
      List<Map<String, dynamic>> mapList = [
        testData,
        {
          'id': 2,
          'name': 'Settings',
          'app_route': '/settings',
          'icon_lib': 'MaterialIcons',
          'icon_name': 'settings',
          'is_authorized': false,
          'order': 2,
        }
      ];

      var dtos = ModuleAuthHomeDTO.fromMapList(mapList);
      expect(dtos.length, equals(2));
      expect(dtos[0].name, equals('Dashboard'));
      expect(dtos[1].name, equals('Settings'));
      expect(dtos[1].icon_lib, equals('MaterialIcons'));
    });
  });
}
