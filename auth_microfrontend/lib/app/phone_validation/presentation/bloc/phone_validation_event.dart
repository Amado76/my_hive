part of 'phone_validation_bloc.dart';

@immutable
sealed class PhoneValidationEvent extends Equatable {
  const PhoneValidationEvent();
}

@immutable
class ResendVerificationCodeToPhone extends PhoneValidationEvent {
  const ResendVerificationCodeToPhone({
    required this.phoneNumber,
    required this.dialCode,
  });

  final String phoneNumber;
  final String dialCode;

  @override
  List<Object?> get props => [phoneNumber, dialCode];
}

@immutable
class VerifyPhoneWithCode extends PhoneValidationEvent {
  const VerifyPhoneWithCode({
    required this.phoneNumber,
    required this.token,
    required this.dialCode,
  });

  final String token;
  final String phoneNumber;
  final String dialCode;

  @override
  List<Object?> get props => [token, phoneNumber, dialCode];
}
