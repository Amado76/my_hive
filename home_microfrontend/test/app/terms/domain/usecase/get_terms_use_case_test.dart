import 'package:flutter_test/flutter_test.dart';
import 'package:home_microfrontend/app/terms/domain/repository/terms_repository_interface.dart';
import 'package:home_microfrontend/app/terms/domain/usecase/get_terms_use_case.dart';
import 'package:mocktail/mocktail.dart';

class TermsRepositoryMock extends Mock implements TermsRepositoryInterface {}

void main() {
  group('[GetTermsUseCase]', () {
    final TermsRepositoryInterface termsRepositoryMock = TermsRepositoryMock();
    final GetTermsUseCase getTermsUseCase =
        GetTermsUseCase(termsRepositoryMock);
    test('should return terms from repository', () async {
      // arrange
      when(() => termsRepositoryMock.getTerms())
          .thenAnswer((_) async => 'terms');
      // act
      final result = await getTermsUseCase();
      // assert
      expect(result, 'terms');
    });
  });
}
