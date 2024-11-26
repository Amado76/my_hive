part of 'login_bloc.dart';

@immutable
sealed class LoginState extends Equatable {
  const LoginState();
}

@immutable
class LoginIdle extends LoginState {
  @override
  List<Object?> get props => [];
}

@immutable
class LoginLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

@immutable
class LoginError extends LoginState {
  final AuthError authError;

  const LoginError({required this.authError});

  @override
  List<Object?> get props => [authError];
}

@immutable
class LoginSuccess extends LoginState {
  @override
  List<Object?> get props => [];
}
