import 'package:flutter_test/flutter_test.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/my_profile_entity.dart';
import 'package:my_profile_microfrontend/app/core/domain/repository/my_profile_repository_interface.dart';
import 'package:my_profile_microfrontend/app/core/domain/usecases/get_profile_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../util/mocks/entity_mocks.dart';

class MyProfileRepositoryMock extends Mock
    implements MyProfileRepositoryInterface {}

void main() {
  late MyProfileRepositoryMock profileRepository;
  late GetProfileUseCase getProfileUseCase;

  setUp(() {
    profileRepository = MyProfileRepositoryMock();
    getProfileUseCase = GetProfileUseCase(profileRepository);
    when(() => profileRepository.getProfile())
        .thenAnswer((_) async => myProfileEntityMock);
  });

  group('[GetProfileUseCase]', () {
    test('should call repository', () async {
      await getProfileUseCase();
      verify(() => profileRepository.getProfile()).called(1);
    });

    test('should return a profile entity', () async {
      final result = await getProfileUseCase();
      expect(result, isA<MyProfileEntity>());
    });
  });
}
