typedef AuthPhoneNumber = String;

extension FormattedPhoneNumber on AuthPhoneNumber {
  String removeNonNumericCharacters() {
    String formattedNumber = replaceAll(RegExp(r'\D'), '');
    return formattedNumber;
  }
}
