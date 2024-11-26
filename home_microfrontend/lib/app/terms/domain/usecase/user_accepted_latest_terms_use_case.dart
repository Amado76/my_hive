import 'package:home_microfrontend/app/terms/domain/repository/terms_repository_interface.dart';

class UserAcceptedLastTermsUseCase {
  final TermsRepositoryInterface _termsRepository;

  UserAcceptedLastTermsUseCase(this._termsRepository);

  Future<bool> call() async {
    return await _termsRepository.userAcceptedLatestTerms();
  }
}
