part of 'student_profile_bloc.dart';

@immutable
sealed class StudentProfileState extends Equatable {
  const StudentProfileState();
}

@immutable
class StudentProfileLoading extends StudentProfileState {
  const StudentProfileLoading();
  @override
  List<Object?> get props => [];
}

@immutable
class StudentProfileSubmitLoading extends StudentProfileState {
  const StudentProfileSubmitLoading();
  @override
  List<Object?> get props => [];
}

@immutable
class StudentProfileSubmitSuccess extends StudentProfileState {
  const StudentProfileSubmitSuccess();
  @override
  List<Object?> get props => [];
}

@immutable
class StudentProfileErrorState extends StudentProfileState {
  final MyProfileError error;

  const StudentProfileErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}

@immutable
class StudentProfileSuccess extends StudentProfileState {
  final MyProfileEntity profile;

  const StudentProfileSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

extension GetProfile on StudentProfileState {
  MyProfileEntity? get profile {
    final state = this;
    if (state is StudentProfileSuccess) {
      return state.profile;
    }

    return null;
  }
}
