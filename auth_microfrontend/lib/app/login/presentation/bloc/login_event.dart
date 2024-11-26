part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

@immutable
class LoginWithPhoneNumber extends LoginEvent {
  const LoginWithPhoneNumber(
      {required this.phoneNumber, required this.password});

  final String phoneNumber;
  final String password;

  @override
  List<Object?> get props => [phoneNumber, password];
}
