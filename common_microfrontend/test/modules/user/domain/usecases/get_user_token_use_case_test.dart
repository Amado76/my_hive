import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/modules/user/data/repositories/auth_user_repository_impl.dart';
import 'package:common_microfrontend/modules/user/domain/entities/auth_user_entity.dart';
import 'package:common_microfrontend/modules/user/domain/usecases/get_user_token_use_case.dart';

import 'package:mocktail/mocktail.dart';

class MockAuthUserRepository extends Mock implements AuthUserRepositoryImpl {}

void main() {
  final mockRepository = MockAuthUserRepository();
  final retrieveUserTokenUseCase = GetUserTokenUseCase(mockRepository);

  test('RetrieveUserTokenUseCase should call retrieve on the repository',
      () async {
    const authUserEntity = AuthUserEntity(accessToken: 'accessToken');
    when(() => mockRepository.retrieve())
        .thenAnswer((_) async => authUserEntity);

    final result = await retrieveUserTokenUseCase();

    verify(() => mockRepository.retrieve()).called(1);
    expect(result, isA<AuthUserEntity>());
    expect(result?.accessToken, authUserEntity.accessToken);
  });
}
