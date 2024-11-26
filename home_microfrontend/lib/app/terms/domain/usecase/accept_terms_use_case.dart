import 'package:home_microfrontend/app/terms/domain/repository/terms_repository_interface.dart';

class AcceptTermsUseCase {
  final TermsRepositoryInterface _termsRepository;
  AcceptTermsUseCase(this._termsRepository);

  Future<void> call() {
    return _termsRepository.acceptTerms();
  }
}
