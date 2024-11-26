import 'package:flutter/foundation.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/my_profile_entity.dart';
import 'package:my_profile_microfrontend/app/core/domain/usecases/get_profile_use_case.dart';
import 'package:my_profile_microfrontend/app/core/domain/usecases/update_profile_use_case.dart';
import 'package:my_profile_microfrontend/app/student/data/dto/update_access_data_dto.dart';
import 'package:my_profile_microfrontend/app/student/domain/dto/student_dto.dart';
import 'package:my_profile_microfrontend/app/util/my_profile_error.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

part 'student_profile_event.dart';
part 'student_profile_state.dart';

class StudentProfileBloc
    extends Bloc<StudentProfileEvent, StudentProfileState> {
  StudentProfileBloc(
    this.getProfile,
    this.updateProfile,
    this.logout,
  ) : super(const StudentProfileLoading()) {
    on<LoadStudentProfile>(_onLoadProfile);
    on<UpdateStudentProfile>(_onUpdateProfile);
  }

  final GetProfileUseCase getProfile;
  final UpdateProfileUseCase updateProfile;
  final DeleteUserTokenUseCase logout;

  void _onLoadProfile(
      LoadStudentProfile event, Emitter<StudentProfileState> emit) async {
    emit(const StudentProfileLoading());
    try {
      final profile = await getProfile();

      emit(StudentProfileSuccess(profile));
    } on Exception catch (e) {
      emit(StudentProfileErrorState(error: MyProfileError.from(e)));
    }
  }

  void _onUpdateProfile(
      UpdateStudentProfile event, Emitter<StudentProfileState> emit) async {
    emit(const StudentProfileSubmitLoading());
    try {
      await updateProfile.call(
          profileDto: event.dataTransferObject, studentId: event.studentId);

      if (event.dataTransferObject is UpdateAccessDataDto) {
        if ((event.dataTransferObject as UpdateAccessDataDto).hasNewPassword) {
          logout();
          Modular.to.navigate(
            Modular.get<NavigationInjector>().getPath(
              package: "baseapp",
              pathKey: "authentication",
            ),
          );
          return;
        }
      }

      emit(const StudentProfileSubmitSuccess());
    } on Exception catch (e) {
      emit(StudentProfileErrorState(error: MyProfileError.from(e)));
    }
  }
}
