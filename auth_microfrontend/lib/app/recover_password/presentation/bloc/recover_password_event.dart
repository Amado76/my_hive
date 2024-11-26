part of 'recover_password_bloc.dart';

@immutable
sealed class RecoverPasswordEvent extends Equatable {
  const RecoverPasswordEvent();
}

@immutable
class SendResetPasswordEmail extends RecoverPasswordEvent {
  const SendResetPasswordEmail({
    required this.email,
  });

  final String email;

  @override
  List<Object?> get props => [email];
}
