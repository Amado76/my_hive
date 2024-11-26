import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/modules/user/data/repositories/auth_user_repository_impl.dart';
import 'package:common_microfrontend/modules/user/domain/usecases/save_user_token_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthUserRepository extends Mock implements AuthUserRepositoryImpl {}

void main() {
  final mockRepository = MockAuthUserRepository();
  final saveUserTokenUseCase = SaveUserTokenUseCase(mockRepository);
  test('SaveUserTokenUseCase should call save on the repository', () async {
    when(() => mockRepository.save(accessToken: any(named: 'accessToken')))
        .thenAnswer((_) => Future.value());

    await saveUserTokenUseCase('accessToken');

    verify(() => mockRepository.save(accessToken: 'accessToken')).called(1);
  });
}
