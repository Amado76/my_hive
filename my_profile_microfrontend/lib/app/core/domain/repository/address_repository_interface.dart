abstract class AddressRepositoryInterface {
  Future<Map<String, dynamic>> getAddressBasedOnPostalCode(String postalCode);
}
