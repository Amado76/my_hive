import 'package:flutter_test/flutter_test.dart';
import 'package:home_microfrontend/app/terms/domain/repository/terms_repository_interface.dart';
import 'package:home_microfrontend/app/terms/domain/usecase/user_accepted_latest_terms_use_case.dart';
import 'package:mocktail/mocktail.dart';

class TermsRepositoryMock extends Mock implements TermsRepositoryInterface {}

void main() {
  final TermsRepositoryInterface termsRepositoryMock = TermsRepositoryMock();
  final UserAcceptedLastTermsUseCase userAcceptedLastTermsUseCase =
      UserAcceptedLastTermsUseCase(termsRepositoryMock);
  group('[UserAcceptedLastTermsUseCase]', () {
    test('Should return true if user accepted latest terms', () async {
      // arrange
      when(() => termsRepositoryMock.userAcceptedLatestTerms())
          .thenAnswer((_) async => true);
      // act
      final result = await userAcceptedLastTermsUseCase();
      // assert
      expect(result, true);
    });
  });
}
