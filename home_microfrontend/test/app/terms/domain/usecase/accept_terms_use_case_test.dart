import 'package:flutter_test/flutter_test.dart';
import 'package:home_microfrontend/app/terms/domain/repository/terms_repository_interface.dart';
import 'package:home_microfrontend/app/terms/domain/usecase/accept_terms_use_case.dart';
import 'package:mocktail/mocktail.dart';

class TermsRepositoryMock extends Mock implements TermsRepositoryInterface {}

void main() {
  final TermsRepositoryInterface termsRepositoryMock = TermsRepositoryMock();
  final AcceptTermsUseCase acceptTermsUseCase =
      AcceptTermsUseCase(termsRepositoryMock);
  group('[AcceptTermsUseCase]', () {
    test('should call the .acceptTerms in TermsRepositoryInterface', () async {
      // arrange
      when(() => termsRepositoryMock.acceptTerms())
          .thenAnswer((_) async => Future.value());
      // act
      await acceptTermsUseCase();
      // assert
      verify(() => termsRepositoryMock.acceptTerms()).called(1);
    });
  });
}
