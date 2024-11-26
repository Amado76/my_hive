// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recover_password_bloc.dart';

@immutable
sealed class RecoverPasswordState extends Equatable {
  const RecoverPasswordState();
}

@immutable
class RecoverPasswordIdle extends RecoverPasswordState {
  @override
  List<Object?> get props => [];
}

@immutable
class RecoverPasswordLoading extends RecoverPasswordState {
  @override
  List<Object?> get props => [];
}

@immutable
class RecoverPasswordError extends RecoverPasswordState {
  const RecoverPasswordError({required this.authError});
  final AuthError authError;
  @override
  List<Object?> get props => [authError];
}

@immutable
class RecoverPasswordSuccess extends RecoverPasswordState {
  final AuthSuccess authSuccess;
  const RecoverPasswordSuccess({
    required this.authSuccess,
  });
  @override
  List<Object?> get props => [authSuccess];
}
