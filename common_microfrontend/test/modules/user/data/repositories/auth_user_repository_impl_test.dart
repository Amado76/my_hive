import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/modules/user/data/repositories/auth_user_repository_impl.dart';
import 'package:common_microfrontend/modules/user/domain/entities/auth_user_entity.dart';
import 'package:common_microfrontend/modules/user/domain/repositories/auth_user_repository_interface.dart';
import 'package:common_microfrontend/util/exception/gtec_exception.dart';
import 'package:common_microfrontend/util/secure_local_storage/secure_local_storage_adapter.dart';
import 'package:mocktail/mocktail.dart';

class SecureLocalStorageAdapterMock extends Mock
    implements SecureLocalStorageAdapter {}

class MockAuthUserRepository extends Mock implements AuthUserRepositoryImpl {}

void main() {
  late AuthUserRepositoryInterface repository;
  late String accessToken;
  late SecureLocalStorageInterface localStorageMock;

  setUp(() {
    localStorageMock = SecureLocalStorageAdapterMock();
    repository = AuthUserRepositoryImpl(localStorage: localStorageMock);
    accessToken = faker.guid.guid();
  });

  group('[repository]', () {
    test('should store accessToken in FlutterSecureStorage', () async {
      when(() => localStorageMock.save(key: 'accessToken', value: accessToken))
          .thenAnswer((_) async {});

      await repository.save(accessToken: accessToken);

      verify(() =>
              localStorageMock.save(key: 'accessToken', value: accessToken))
          .called(1);
    });

    test('should delete accessToken from FlutterSecureStorage', () async {
      when(() => localStorageMock.get(key: 'accessToken'))
          .thenAnswer((_) async => accessToken);
      when(() => localStorageMock.delete(key: 'accessToken'))
          .thenAnswer((_) async {});

      await repository.delete();

      verify(() => localStorageMock.delete(key: 'accessToken')).called(1);
    });

    test('should retrieve AuthUserEntity from FlutterSecureStorage', () async {
      final authUserEntity = AuthUserEntity(accessToken: accessToken);
      when(() => localStorageMock.get(key: 'accessToken'))
          .thenAnswer((_) async => accessToken);

      final retrievedEntity = await repository.retrieve();

      verify(() => localStorageMock.get(key: 'accessToken')).called(1);
      expect(retrievedEntity, isA<AuthUserEntity>());
      expect(retrievedEntity?.accessToken, authUserEntity.accessToken);
    });

    test(
        'should throw GTecException when trying to delete a non-existing token',
        () {
      when(() => localStorageMock.get(key: 'accessToken'))
          .thenAnswer((_) async => null);
      expect(repository.delete, throwsA(isA<GTecException>()));
    });
  });

  group('[stream]', () {
    test('emits token when save is called', () async {
      when(() => localStorageMock.save(key: 'accessToken', value: accessToken))
          .thenAnswer((_) async {});

      repository.save(accessToken: accessToken);

      await expectLater(
        repository.authTokenStream,
        emits(predicate<AuthUserEntity>(
            (entity) => entity.accessToken == accessToken)),
      );
    });

    test('emits null token when delete is called', () async {
      when(() => localStorageMock.get(key: 'accessToken'))
          .thenAnswer((_) async => accessToken);
      when(() => localStorageMock.delete(key: 'accessToken'))
          .thenAnswer((_) async {});

      repository.delete();

      await expectLater(
        repository.authTokenStream,
        emits(
            predicate<AuthUserEntity>((entity) => entity.accessToken == null)),
      );
    });
  });

  tearDown(() => repository.dispose());
}
