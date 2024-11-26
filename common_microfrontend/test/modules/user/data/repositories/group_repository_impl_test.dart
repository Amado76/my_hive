// Criando mocks
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/modules/user/data/repositories/group_repository_impl.dart';
import 'package:common_microfrontend/modules/user/domain/entities/group_entity.dart';

import 'package:mocktail/mocktail.dart';

class MockHttpClientInterface extends Mock implements DioAdapter {}

class MockUrlInjector extends Mock implements UrlInjector {}

void main() {
  group('GroupRepositoryImpl', () {
    late MockHttpClientInterface mockHttpClient;
    late MockUrlInjector mockUrlInjector;
    late GroupRepositoryImpl groupRepository;

    setUp(() {
      mockHttpClient = MockHttpClientInterface();
      mockUrlInjector = MockUrlInjector();
      groupRepository = GroupRepositoryImpl(
        httpClient: mockHttpClient,
        urlInjector: mockUrlInjector,
      );
    });

    test('getGroup should return a list of GroupEntity', () async {
      // Preparando os dados de simulação
      const String mockUrl = 'http://api.example.com/get_profiles';
      final Map<String, dynamic> apiResponse = {
        'data': {
          'groups': [
            {
              'name': 'Test Group',
              'name_profile': 'Test Profile',
              'community_id': 123,
              'logo_url': 'http://example.com/logo.png',
              'room_id': 678,
              'room': 'Room 1'
            }
          ]
        }
      };

      // Configurando as expectativas nos mocks
      when(() => mockUrlInjector.getEndPoint(
            endpoint: 'get_profiles',
            package: 'user_common',
          )).thenReturn(mockUrl);

      when(() => mockHttpClient.get(
            path: mockUrl,
          )).thenAnswer((_) async => (
            data: apiResponse,
            statusCode: 200,
          ));

      // Chamando o método testado
      var result = await groupRepository.getGroup();

      // Verificando os resultados
      expect(result, isA<List<GroupEntity>>());
      expect(result.length, equals(1));
      expect(result.first.name, equals('Test Group'));

      // Verificações
      verify(() => mockUrlInjector.getEndPoint(
            endpoint: 'get_profiles',
            package: 'user_common',
          )).called(1);
      verify(() => mockHttpClient.get(
            path: mockUrl,
          )).called(1);
    });
  });
}
