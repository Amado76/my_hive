import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_profile_microfrontend/app/core/data/repository/my_profile_repository_impl.dart';
import 'package:my_profile_microfrontend/app/core/domain/repository/my_profile_repository_interface.dart';
import 'package:my_profile_microfrontend/app/core/domain/usecases/get_profile_use_case.dart';
import 'package:my_profile_microfrontend/app/core/domain/usecases/update_profile_use_case.dart';
import 'package:my_profile_microfrontend/app/student/presentation/bloc/student_profile_bloc.dart';
import 'package:my_profile_microfrontend/app/util/my_profile_error.dart';
import 'package:my_profile_microfrontend/l10n/translation_my_profile.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../util/mocks/dto_mocks.dart';
import '../../../../util/mocks/entity_mocks.dart';

class StudentRepositoryMock extends Mock implements MyProfileRepositoryImpl {}

class UserRepositoryMock extends Mock implements AuthUserRepositoryInterface {}

class GeneralConfigModular extends Module {
  @override
  List<Module> get imports => [
        CommonModule(),
      ];
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Modular.bindModule(GeneralConfigModular());

  final GeneralConfig gc = Modular.get<GeneralConfig>();
  gc.reset();
  gc.buildBusiness = '';
  gc.business = GeneralBusiness.education;
  gc.language = WidgetsBinding.instance.platformDispatcher.locale.languageCode;

  Modular.get<Translation>().registerTranslations(
    TranslationMyProfile(),
  );

  late StudentProfileBloc studentBloc;
  late MyProfileRepositoryInterface myProfileMock;
  late AuthUserRepositoryInterface userRepository;
  late GetProfileUseCase getProfileUseCase;
  late UpdateProfileUseCase updateProfileUseCase;
  late DeleteUserTokenUseCase logout;

  setUp(() {
    myProfileMock = StudentRepositoryMock();
    userRepository = UserRepositoryMock();
    getProfileUseCase = GetProfileUseCase(myProfileMock);
    updateProfileUseCase = UpdateProfileUseCase(myProfileMock);
    logout = DeleteUserTokenUseCase(userRepository);
    studentBloc =
        StudentProfileBloc(getProfileUseCase, updateProfileUseCase, logout);
  });

  group('when [LoadStudentProfile] is added', () {
    blocTest<StudentProfileBloc, StudentProfileState>(
      'emits [LoadStudentProfile] with entities.',
      build: () => studentBloc,
      setUp: () {
        when(() => myProfileMock.getProfile())
            .thenAnswer((_) async => myProfileEntityMock);
      },
      act: (bloc) => bloc.add(const LoadStudentProfile()),
      expect: () => [
        const StudentProfileLoading(),
        StudentProfileSuccess(myProfileEntityMock),
      ],
    );

    blocTest<StudentProfileBloc, StudentProfileState>(
      'emits [MyProfileUnknownError] when fail',
      build: () => studentBloc,
      setUp: () {
        when(() => myProfileMock.getProfile())
            .thenThrow(GTecException(message: ''));
      },
      act: (bloc) => bloc.add(const LoadStudentProfile()),
      expect: () => [
        const StudentProfileLoading(),
        StudentProfileErrorState(error: MyProfileUnknownError())
      ],
    );
  });

  group('when [UpdateStudentProfile] is added', () {
    blocTest<StudentProfileBloc, StudentProfileState>(
      'emits [TeacherProfileSubmitSuccess] with entities.',
      build: () => studentBloc,
      setUp: () {
        when(() => myProfileMock.updateProfile(
              updateAccessDataDtoMock,
              1,
            )).thenAnswer((_) async => Future.value());
      },
      act: (bloc) => bloc.add(UpdateStudentProfile(
          dataTransferObject: updateAccessDataDtoMock, studentId: 1)),
      expect: () => [
        const StudentProfileSubmitLoading(),
        const StudentProfileSubmitSuccess(),
      ],
    );

    blocTest<StudentProfileBloc, StudentProfileState>(
      'emits [MyProfileUnknownError] when fail',
      build: () => studentBloc,
      setUp: () {
        when(() => myProfileMock.updateProfile(
              updateAccessDataDtoMock,
              1,
            )).thenThrow(GTecException(message: ''));
      },
      act: (bloc) => bloc.add(UpdateStudentProfile(
          dataTransferObject: updateAccessDataDtoMock, studentId: 1)),
      expect: () => [
        const StudentProfileSubmitLoading(),
        StudentProfileErrorState(error: MyProfileUnknownError())
      ],
    );
  });
}
