import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/modules/user/data/repositories/auth_user_repository_impl.dart';
import 'package:common_microfrontend/modules/user/domain/usecases/delete_user_token_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthUserRepository extends Mock implements AuthUserRepositoryImpl {}

void main() {
  final mockRepository = MockAuthUserRepository();
  final deleteUserTokenUseCase = DeleteUserTokenUseCase(mockRepository);
  test('DeleteUserTokenUseCase should call delete on the repository', () async {
    when(() => mockRepository.delete()).thenAnswer((_) => Future.value());

    await deleteUserTokenUseCase();

    verify(() => mockRepository.delete()).called(1);
  });
}
