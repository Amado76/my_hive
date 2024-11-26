abstract class TermsRepositoryInterface {
  Future<String> getTerms();
  Future<void> acceptTerms();
  Future<bool> userAcceptedLatestTerms();
}
