import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/modules/user/data/dtos/module_auth_drawer_dto.dart';

void main() {
  group('ModuleAuthDrawerDTO', () {
    // Dados de teste
    final Map<String, dynamic> testData = {
      'id': 1,
      'name': 'Admin Panel',
      'app_route': '/admin',
      'icon_lib': 'FontAwesome',
      'icon_name': 'fa-admin',
      'is_authorized': true,
      'order': 1,
    };

    // Teste para fromMap
    test('should create an instance from map', () {
      var dto = ModuleAuthDrawerDTO.fromMap(testData);
      expect(dto.id, equals(1));
      expect(dto.name, equals('Admin Panel'));
      expect(dto.app_route, equals('/admin'));
      expect(dto.icon_lib, equals('FontAwesome'));
      expect(dto.icon_name, equals('fa-admin'));
      expect(dto.is_authorized, isTrue);
      expect(dto.order, equals(1));
    });

    // Teste para toJson
    test('should convert to json string correctly', () {
      var dto = ModuleAuthDrawerDTO.fromMap(testData);
      String json = dto.toJson();
      expect(json, isA<String>());
      expect(json, contains('"name":"Admin Panel"'));
    });

    // Teste para fromJson
    test('should create an instance from json string', () {
      String jsonStr =
          '{"id":1,"name":"Admin Panel","app_route":"/admin","icon_lib":"FontAwesome","icon_name":"fa-admin","is_authorized":true,"order":1}';
      var dto = ModuleAuthDrawerDTO.fromJson(jsonStr);
      expect(dto.id, equals(1));
      expect(dto.name, equals('Admin Panel'));
      expect(dto.app_route, equals('/admin'));
    });

    // Teste para fromMapList
    test(
        'should convert a list of maps to a list of ModuleAuthDrawerDTO objects',
        () {
      List<Map<String, dynamic>> mapList = [
        {
          'id': 1,
          'name': 'Admin Panel',
          'app_route': '/admin',
          'icon_lib': 'FontAwesome',
          'icon_name': 'fa-admin',
          'is_authorized': true,
          'order': 1,
        },
        {
          'id': 2,
          'name': 'User Dashboard',
          'app_route': '/dashboard',
          'icon_lib': 'MaterialIcons',
          'icon_name': 'dashboard',
          'is_authorized': false,
          'order': 2,
        }
      ];

      var dtos = ModuleAuthDrawerDTO.fromMapList(mapList);
      expect(dtos.length, equals(2));
      expect(dtos[0].name, equals('Admin Panel'));
      expect(dtos[1].name, equals('User Dashboard'));
      expect(dtos[1].icon_lib, equals('MaterialIcons'));
    });
  });
}
