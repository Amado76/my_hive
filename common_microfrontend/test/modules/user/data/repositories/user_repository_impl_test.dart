import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/modules/user/data/repositories/user_repository_impl.dart';

import 'package:mocktail/mocktail.dart';

class MockHttpClientInterface extends Mock implements HttpClientInterface {}

class MockUrlInjector extends Mock implements UrlInjector {}

void main() {
  late MockHttpClientInterface mockHttpClient;
  late MockUrlInjector mockUrlInjector;
  late UserRepositoryImpl userRepository;

  setUp(() {
    mockHttpClient = MockHttpClientInterface();
    mockUrlInjector = MockUrlInjector();
    userRepository = UserRepositoryImpl(
        httpClient: mockHttpClient, urlInjector: mockUrlInjector);
  });

  group(
    'getUser',
    () {
      test(
        'should return a combined UserEntity from both _getUserMe and _getUserProfile',
        () async {
          // Arrange
          final userMeApiResponse = {
            'data': {
              "formatted_name": "Bruno Amado",
              "birthdate": null,
              "picture": "https://teste.com",
              "last_community_name": "Aluno",
              "name_profile": "Aluno",
              "last_community_id": 411,
              "room_id": 8789,
              "email": "brunoamado@teste.com.br",
            }
          };
          final userProfileApiResponse = {
            'data': {
              "first_name": "Bruno",
              "last_name": "Amado",
              "formatted_name": "Bruno Amado",
              "phone_number": "31992002666",
              "email": "brunoamado@teste.com.br",
              "cpf": "",
              "birthdate": "",
              "description": "",
              "picture_url": "https://teste.com"
            }
          };
          when(() => mockUrlInjector.getEndPoint(
              endpoint: 'get_me',
              package: 'user_common')).thenReturn('mockUrlGetUserMe');
          when(() => mockUrlInjector.getEndPoint(
              endpoint: 'get_current_profile',
              package: 'user_common')).thenReturn('mockUrlGetUserProfile');
          when(() => mockHttpClient.get(path: 'mockUrlGetUserMe'))
              .thenAnswer((_) async => (
                    data: userMeApiResponse,
                    statusCode: 200,
                  ));
          when(() => mockHttpClient.get(path: 'mockUrlGetUserProfile'))
              .thenAnswer((_) async => (
                    data: userProfileApiResponse,
                    statusCode: 200,
                  ));

          // Act
          final result = await userRepository.getUser();

          // Assert
          verify(() => mockHttpClient.get(path: 'mockUrlGetUserMe')).called(1);
          verify(() => mockHttpClient.get(path: 'mockUrlGetUserProfile'))
              .called(1);
          expect(result.email, equals("brunoamado@teste.com.br"));
          expect(result.phoneNumber, equals("31992002666"));
          expect(result.fullName, equals("Bruno Amado"));
        },
      );
    },
  );

  group(
    '_getUserMe',
    () {
      test(
        'should fetch user data and convert it to UserEntity',
        () async {
          final Map<String, dynamic> apiResponse = {
            'data': {
              "formatted_name": "Bruno Amado",
              "cpf": "",
              "birthdate": null,
              "picture": "https://teste.com",
              "last_community_name": "Aluno",
              "name_profile": "Aluno",
              "last_community_id": 411,
              "room_id": 8789,
              "email": "brunoamado@teste.com.br",
            }
          };
          // Arrange
          when(() => mockUrlInjector.getEndPoint(
                endpoint: 'get_me',
                package: 'user_common',
              )).thenReturn('mockUrlGetUserMe');

          when(() => mockHttpClient.get(
                path: 'mockUrlGetUserMe',
              )).thenAnswer((_) async => (
                data: apiResponse,
                statusCode: 200,
              ));
          // Act
          final result = await userRepository.getUserMeForTesting();

          // Assert
          expect(result.email, equals("brunoamado@gtecapp.com.br"));
        },
      );
    },
  );

  group(
    '_getUserProfile',
    () {
      test(
        'should fetch user profile data and convert it to UserEntity',
        () async {
          final Map<String, dynamic> apiResponse = {
            'data': {
              "first_name": "Bruno",
              "last_name": "Amado",
              "formatted_name": "Bruno Amado",
              "phone_number": "31992002666",
              "email": "brunoamado@teste.com.br",
              "cpf": "",
              "nif": "",
              "healthcare_plan": "",
              "reference_hospital": "",
              "birthdate": "",
              "description": "",
              "picture_url": "https://teste.com",
            }
          };
          // Arrange
          when(() => mockUrlInjector.getEndPoint(
                endpoint: 'get_current_profile',
                package: 'user_common',
              )).thenReturn('mockUrlGetUserProfile');

          when(() => mockHttpClient.get(
                path: 'mockUrlGetUserProfile',
              )).thenAnswer((_) async => (
                data: apiResponse,
                statusCode: 200,
              ));
          // Act
          final result = await userRepository.getUserProfileForTesting();

          // Assert
          expect(result.phoneNumber, equals("31992002666"));
          expect(result.fullName, equals("Bruno Amado"));
        },
      );
    },
  );
}
