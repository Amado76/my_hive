part of 'phone_validation_bloc.dart';

@immutable
sealed class PhoneValidationState extends Equatable {
  const PhoneValidationState();
}

@immutable
class PhoneValidationIdle extends PhoneValidationState {
  @override
  List<Object?> get props => [];
}

@immutable
class PhoneValidationLoading extends PhoneValidationState {
  const PhoneValidationLoading();
  @override
  List<Object?> get props => [];
}

@immutable
class PhoneValidationErrorState extends PhoneValidationState {
  final PhoneValidationError phoneValidationError;

  const PhoneValidationErrorState({required this.phoneValidationError});

  @override
  List<Object?> get props => [phoneValidationError];
}

@immutable
class PhoneValidationCodeResent extends PhoneValidationState {
  const PhoneValidationCodeResent();

  @override
  List<Object?> get props => [];
}

@immutable
class PhoneValidationSuccess extends PhoneValidationState {
  const PhoneValidationSuccess({required this.phoneNumber});
  final String? phoneNumber;

  @override
  List<Object?> get props => [phoneNumber];
}

extension GetPhoneNumber on PhoneValidationState {
  String? get phoneNumber {
    final state = this;
    if (state is PhoneValidationSuccess) {
      return state.phoneNumber;
    }
    return null;
  }
}
