part of 'send_validation_sms_bloc.dart';

@immutable
sealed class SendValidationSmsEvent extends Equatable {
  const SendValidationSmsEvent();
}

@immutable
class SendVerificationCodeToPhone extends SendValidationSmsEvent {
  const SendVerificationCodeToPhone({
    required this.phoneNumber,
    required this.dialCode,
  });

  final String phoneNumber;
  final String dialCode;

  @override
  List<Object?> get props => [phoneNumber, dialCode];
}
