import 'package:home_microfrontend/app/terms/domain/repository/terms_repository_interface.dart';

class GetTermsUseCase {
  final TermsRepositoryInterface _termsRepository;
  GetTermsUseCase(this._termsRepository);

  Future<String> call() {
    return _termsRepository.getTerms();
  }
}
