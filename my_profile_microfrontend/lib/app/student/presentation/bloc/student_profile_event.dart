part of 'student_profile_bloc.dart';

@immutable
sealed class StudentProfileEvent extends Equatable {
  const StudentProfileEvent();
}

@immutable
class LoadStudentProfile extends StudentProfileEvent {
  const LoadStudentProfile();

  @override
  List<Object?> get props => [];
}

@immutable
class UpdateStudentProfile extends StudentProfileEvent {
  final StudentDto dataTransferObject;
  final int? studentId;

  const UpdateStudentProfile(
      {required this.dataTransferObject, this.studentId});

  @override
  List<Object?> get props => [dataTransferObject, studentId];
}
