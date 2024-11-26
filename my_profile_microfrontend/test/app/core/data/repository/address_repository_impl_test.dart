import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_profile_microfrontend/app/core/data/repository/address_repository_impl.dart';
import 'package:my_profile_microfrontend/app/core/domain/repository/address_repository_interface.dart';
import 'package:common_microfrontend/util/http_client/http_client_adapter.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../util/mocks/response_mocks.dart';

class HttpClientAdapterMock extends Mock implements DioAdapter {}

void main() {
  late HttpClientInterface httpClientAdapterMock;
  late AddressRepositoryInterface addressRepository;
  late String addressUrl;
  late String postalCode;

  setUp(
    () => {
      httpClientAdapterMock = HttpClientAdapterMock(),
      addressRepository = AddressRepositoryImpl(
        httpClient: httpClientAdapterMock,
      ),
      addressUrl = 'https://viacep.com.br/ws/',
      postalCode = faker.address.zipCode(),
    },
  );

  group('[Address Repository]', () {
    test('Should return the address', () async {
      when(() => httpClientAdapterMock.get(path: '$addressUrl$postalCode/json'))
          .thenAnswer((_) async => (data: viaCepMock, statusCode: 200));

      final result =
          await addressRepository.getAddressBasedOnPostalCode(postalCode);
      expect(result, isA<Map<String, dynamic>>());
      expect(result, viaCepMock);
    });
  });
}
