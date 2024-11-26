part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent extends Equatable {
  const RegisterEvent();
}

@immutable
class RegisterChangeAvatar extends RegisterEvent {
  const RegisterChangeAvatar({required this.image});
  final XFile? image;
  @override
  List<Object?> get props => [image];
}

@immutable
class RegisterNewUser extends RegisterEvent {
  const RegisterNewUser({
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.classCode,
    required this.email,
    this.cpf,
    this.image,
  });
  final String phoneNumber;
  final XFile? image;
  final String firstName;
  final String lastName;
  final String email;
  final String? cpf;
  final String password;
  final String classCode;

  @override
  List<Object?> get props => [email];
}
