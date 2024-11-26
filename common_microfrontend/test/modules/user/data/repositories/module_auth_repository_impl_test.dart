// Criando mocks
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/modules/user/data/repositories/module_auth_repository_impl.dart';
import 'package:common_microfrontend/modules/user/domain/entities/module_auth_drawer_entity.dart';
import 'package:common_microfrontend/modules/user/domain/entities/module_auth_home_entity.dart';

import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements HttpClientInterface {}

class MockUrlInjector extends Mock implements UrlInjector {}

void main() {
  group('ModuleAuthRepositoryImpl', () {
    late MockHttpClient mockHttpClient;
    late MockUrlInjector mockUrlInjector;
    late ModuleAuthRepositoryImpl repository;

    setUp(() {
      mockHttpClient = MockHttpClient();
      mockUrlInjector = MockUrlInjector();
      repository = ModuleAuthRepositoryImpl(
        httpClient: mockHttpClient,
        urlInjector: mockUrlInjector,
      );
    });

    test(
        'get Modules home and drawer should return a list of ModuleAuthHomeEntity and ModuleAuthDrawerEntity',
        () async {
      // Preparando os dados de simulação
      const String mockUrl = 'http://api.example.com/sys/modules_auth';
      final Map<String, dynamic> apiResponse = {
        'data': {
          'modules': [
            {
              'id': 1,
              'name': 'Admin Panel Drawer',
              'app_route': '/admin',
              'icon_lib': 'FontAwesome',
              'icon_name': 'fa-admin',
              'is_authorized': true,
              'order': 1,
            }
          ],
          'home': [
            {
              'id': 1,
              'name': 'Admin Panel Home',
              'app_route': '/admin',
              'icon_lib': 'FontAwesome',
              'icon_name': 'fa-admin',
              'is_authorized': true,
              'order': 1,
            }
          ]
        }
      };

      // Configurando as expectativas nos mocks
      when(() => mockUrlInjector.getEndPoint(
            endpoint: 'get_modules_auth',
            package: 'user_common',
          )).thenReturn(mockUrl);

      when(() => mockHttpClient.get(
            path: mockUrl,
          )).thenAnswer((_) async => (
            data: apiResponse,
            statusCode: 200,
          ));

      // Chamando o método testado
      var resultHome = await repository.getModuleAuthHome();
      var resultDrawer = await repository.getModuleAuthDrawer();

      // Verificando os resultados
      expect(resultHome, isA<List<ModuleAuthHomeEntity>>());
      expect(resultHome.length, equals(1));
      expect(resultHome.first.name, equals('Admin Panel Home'));

      expect(resultDrawer, isA<List<ModuleAuthDrawerEntity>>());
      expect(resultDrawer.length, equals(1));
      expect(resultDrawer.first.name, equals('Admin Panel Drawer'));

      // Verificações
      verify(() => mockUrlInjector.getEndPoint(
            endpoint: 'get_modules_auth',
            package: 'user_common',
          )).called(2);
      verify(() => mockHttpClient.get(
            path: mockUrl,
          )).called(2);
    });
  });
}
