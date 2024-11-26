// Mock class for GeneralConfig
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/modules/user/domain/entities/group_entity.dart';
import 'package:common_microfrontend/modules/user/domain/entities/user_entity.dart';

import 'package:mocktail/mocktail.dart';

class MockGeneralConfig extends Mock implements GeneralConfig {}

void main() {
  late MockGeneralConfig mockGeneralConfig;
  late GetCurrentProfileUseCase getCurrentProfile;
  late UserEntity userEntity;

  setUp(() {
    mockGeneralConfig = MockGeneralConfig();
    getCurrentProfile = GetCurrentProfileUseCase(mockGeneralConfig);
    userEntity = UserEntity(
      firstName: 'John',
      lastName: 'Doe',
      fullName: 'John Doe',
      phoneNumber: '1234567890',
      email: 'john.doe@example.com',
      cpf: '123.456.789-09',
      birthdate: '1980-01-01',
      description: 'A brief description',
      pictureUrl: 'http://example.com/image.jpg',
      lastCommunityName: 'Profile1',
      nameProfile: 'Advanced',
      lastCommunityId: 10,
      userId: 1,
      roomId: 1,
      modulesAuthDrawer: const [],
      modulesAuthHome: const [],
      groups: const [
        GroupEntity(
          name: 'Profile1',
          nameProfile: 'Profile1',
          communityId: 10,
          roomId: 1,
          logoUrl: 'test.jpg',
          room: 'Test Room',
          dependent: null,
          dependentId: null,
        ),
        GroupEntity(
          name: 'Profile2',
          nameProfile: 'Profile2',
          communityId: 2,
          roomId: 2,
          logoUrl: 'test.jpg',
          room: 'Test Room',
          dependent: null,
          dependentId: null,
        ),
      ],
    );
  });

  group('GetCurrentProfile', () {
    test('throws an exception when userEntity is null', () {
      when(() => mockGeneralConfig.userEntity).thenReturn(null);

      expect(() => getCurrentProfile.call(), throwsA(isA<Exception>()));
    });

    test('returns the correct profile when userEntity is not null', () async {
      when(() => mockGeneralConfig.userEntity).thenReturn(userEntity);

      final result = getCurrentProfile.call();

      expect(result.nameProfile, 'Profile1');

      expect(result.roomId, 1);
    });

    test('throws GTecException when no matching profile is found', () async {
      final UserEntity userEntityException =
          userEntity.copyWith(lastGroupName: 'Profile3');

      when(() => mockGeneralConfig.userEntity).thenReturn(userEntityException);

      expect(() => getCurrentProfile.call(), throwsA(isA<GTecException>()));
    });
  });
}
