part of 'send_validation_sms_bloc.dart';

@immutable
sealed class SendValidationSmsState extends Equatable {
  const SendValidationSmsState();
}

@immutable
class SendValidationSmsIdle extends SendValidationSmsState {
  @override
  List<Object?> get props => [];
}

@immutable
class SendValidationSmsLoading extends SendValidationSmsState {
  const SendValidationSmsLoading();
  @override
  List<Object?> get props => [];
}

@immutable
class SendValidationSmsErrorState extends SendValidationSmsState {
  final SendValidationSmsError sendValidationSmsError;
  const SendValidationSmsErrorState({required this.sendValidationSmsError});

  @override
  List<Object?> get props => [sendValidationSmsError];
}

@immutable
class SendValidationSmsSuccess extends SendValidationSmsState {
  const SendValidationSmsSuccess(
      {required this.phoneNumber, required this.dialCode});
  final String phoneNumber;
  final String dialCode;
  @override
  List<Object?> get props => [phoneNumber, dialCode];
}

extension GetPhoneNumber on SendValidationSmsState {
  String? get phoneNumber {
    final state = this;
    if (state is SendValidationSmsSuccess) {
      return state.phoneNumber;
    }
    return null;
  }
}

extension GetDialCode on SendValidationSmsState {
  String? get dialCode {
    final state = this;
    if (state is SendValidationSmsSuccess) {
      return state.dialCode;
    }
    return null;
  }
}
