import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/modules/user/domain/repositories/module_auth_repository_interface.dart';
import 'package:common_microfrontend/modules/user/domain/repositories/user_repository_interface.dart';
import 'package:common_microfrontend/modules/user/domain/usecases/generate_user_entity_use_case.dart';
import 'package:mocktail/mocktail.dart';
import 'package:common_microfrontend/modules/user/domain/entities/group_entity.dart';
import 'package:common_microfrontend/modules/user/domain/entities/module_auth_drawer_entity.dart';
import 'package:common_microfrontend/modules/user/domain/entities/module_auth_home_entity.dart';
import 'package:common_microfrontend/modules/user/domain/entities/user_entity.dart';
import 'package:common_microfrontend/modules/user/domain/repositories/group_repository_interface.dart';

class MockGroupRepository extends Mock implements GroupRepositoryInterface {}

class MockUserRepository extends Mock implements UserRepositoryInterface {}

class MockModuleAuthRepository extends Mock
    implements ModuleAuthRepositoryInterface {}

void main() {
  late MockGroupRepository mockGroupRepository;
  late MockUserRepository mockUserRepository;
  late MockModuleAuthRepository mockModuleAuthRepository;
  late GenerateUserEntityUseCase useCase;

  setUp(() {
    mockGroupRepository = MockGroupRepository();
    mockUserRepository = MockUserRepository();
    mockModuleAuthRepository = MockModuleAuthRepository();
    useCase = GenerateUserEntityUseCase(
      mockGroupRepository,
      mockUserRepository,
      mockModuleAuthRepository,
    );
  });

  group('GenerateUserEntityUseCase Tests', () {
    test(
        'deve emitir a entidade de usuário atualizada após agregação dos dados',
        () async {
      final testGroups = [
        const GroupEntity(
          name: "Group 1",
          nameProfile: "Profile 1",
          communityId: 1,
          logoUrl: "url",
          roomId: 3,
          room: "Room A",
          dependent: null,
          dependentId: null,
        )
      ];
      final testModulesHome = [
        const ModuleAuthHomeEntity(
            id: 1,
            name: "HomeModule1",
            appRoute: "/home",
            iconLib: "material",
            iconName: "home",
            isAuthorized: true,
            order: 1)
      ];
      final testModulesDrawer = [
        const ModuleAuthDrawerEntity(
            id: 2,
            name: "DrawerModule1",
            appRoute: "/drawer",
            iconLib: "material",
            iconName: "menu",
            isAuthorized: true,
            order: 2)
      ];
      final testUser = UserEntity(
        firstName: "John",
        lastName: "Doe",
        fullName: "John Doe",
        phoneNumber: "999888777",
        email: "john.doe@example.com",
        cpf: "123.456.789-00",
        birthdate: "1990-01-01",
        description: "A sample user",
        pictureUrl: "https://example.com/picture.jpg",
        nameProfile: "Developer",
        roomId: 4,
        groups: testGroups,
        modulesAuthHome: testModulesHome,
        modulesAuthDrawer: testModulesDrawer,
        lastCommunityId: 1,
        lastCommunityName: 'Community 1',
        userId: 1,
      );

      // Arranjos para as chamadas do repositório
      when(() => mockGroupRepository.getGroup())
          .thenAnswer((_) async => testGroups);
      when(() => mockUserRepository.getUser())
          .thenAnswer((_) async => testUser);
      when(() => mockModuleAuthRepository.getModuleAuthHome())
          .thenAnswer((_) async => testModulesHome);
      when(() => mockModuleAuthRepository.getModuleAuthDrawer())
          .thenAnswer((_) async => testModulesDrawer);

      expectLater(useCase.userEntityStream, emitsInOrder([testUser]));

      // Act
      await useCase.call();

      // Assert
      verify(() => mockGroupRepository.getGroup()).called(1);
      verify(() => mockUserRepository.getUser()).called(1);
      verify(() => mockModuleAuthRepository.getModuleAuthHome()).called(1);
      verify(() => mockModuleAuthRepository.getModuleAuthDrawer()).called(1);
    });
  });
}
