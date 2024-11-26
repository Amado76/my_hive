import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:my_profile_microfrontend/app/core/domain/repository/address_repository_interface.dart';

class AddressRepositoryImpl implements AddressRepositoryInterface {
  final HttpClientInterface _httpClient;
  final String url = 'https://viacep.com.br/ws/';

  AddressRepositoryImpl({
    required HttpClientInterface httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<Map<String, dynamic>> getAddressBasedOnPostalCode(
      String postalCode) async {
    final response = await _httpClient.get(path: '$url$postalCode/json');
    return response.data;
  }
}
