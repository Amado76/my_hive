import 'package:flutter_test/flutter_test.dart';
import 'package:my_profile_microfrontend/app/core/data/repository/my_profile_repository_impl.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/my_profile_entity.dart';
import 'package:my_profile_microfrontend/app/core/domain/repository/my_profile_repository_interface.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../util/mocks/response_mocks.dart';

class UrlInjectorMock extends Mock implements UrlInjector {}

class HttpClientAdapterMock extends Mock implements DioAdapter {}

void main() {
  late HttpClientInterface httpClientAdapterMock;
  late UrlInjector urlInjectorMock;
  late MyProfileRepositoryInterface profileRepository;
  late String readProfile;

  setUp(() => {
        httpClientAdapterMock = HttpClientAdapterMock(),
        urlInjectorMock = UrlInjectorMock(),
        profileRepository = MyProfileRepositoryImpl(
          httpClient: httpClientAdapterMock,
          urlInjector: urlInjectorMock,
        ),
        readProfile = '/apiv3/me/profile',
      });

  group('[My Profile Repository]', () {
    test('Should return the profile', () async {
      when(() => urlInjectorMock.getEndPoint(
          package: 'my_profile',
          endpoint: 'readProfile')).thenReturn(readProfile);
      when(() => httpClientAdapterMock.get(path: readProfile))
          .thenAnswer((_) async => (data: getProfileDataMock, statusCode: 200));

      final result = await profileRepository.getProfile();
      expect(result, isA<MyProfileEntity>());
    });
  });
}
