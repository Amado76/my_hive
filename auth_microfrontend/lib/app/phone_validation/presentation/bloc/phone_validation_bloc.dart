import 'package:flutter/foundation.dart' show immutable;
import 'package:auth_microfrontend/app/core/domain/use_case/send_verification_code_to_phone_use_case.dart';
import 'package:auth_microfrontend/app/phone_validation/domain/use_case/verify_phone_with_code_use_case.dart';
import 'package:auth_microfrontend/app/phone_validation/util/phone_validation_error.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

part 'phone_validation_state.dart';
part 'phone_validation_event.dart';

class PhoneValidationBloc
    extends Bloc<PhoneValidationEvent, PhoneValidationState> {
  PhoneValidationBloc({
    required SendVerificationCodeToPhoneUseCase
        sendVerificationCodeToPhoneUseCase,
    required VerifyPhoneWithCodeUseCase verifyPhoneWithCodeUseCase,
  })  : _sendVerificationCodeToPhoneUseCase =
            sendVerificationCodeToPhoneUseCase,
        _verifyPhoneWithCodeUseCase = verifyPhoneWithCodeUseCase,
        super(PhoneValidationIdle()) {
    on<VerifyPhoneWithCode>(_onVerifyPhoneWithCode);
    on<ResendVerificationCodeToPhone>(_onResendVerificationCodeToPhone);
  }

  final SendVerificationCodeToPhoneUseCase _sendVerificationCodeToPhoneUseCase;
  final VerifyPhoneWithCodeUseCase _verifyPhoneWithCodeUseCase;

  void _onResendVerificationCodeToPhone(ResendVerificationCodeToPhone event,
      Emitter<PhoneValidationState> emit) async {
    emit(const PhoneValidationLoading());
    try {
      await _sendVerificationCodeToPhoneUseCase(
          phoneNumber: event.phoneNumber, dialCode: event.dialCode);
      emit(const PhoneValidationCodeResent());
    } on Exception catch (e) {
      emit(PhoneValidationErrorState(
          phoneValidationError: PhoneValidationError.from(e)));
    }
  }

  void _onVerifyPhoneWithCode(
      VerifyPhoneWithCode event, Emitter<PhoneValidationState> emit) async {
    emit(const PhoneValidationLoading());
    try {
      await _verifyPhoneWithCodeUseCase(
          phoneNumber: event.phoneNumber,
          token: event.token,
          dialCode: event.dialCode);
      emit(PhoneValidationSuccess(phoneNumber: event.phoneNumber));
    } on Exception catch (e) {
      emit(PhoneValidationErrorState(
        phoneValidationError: PhoneValidationError.from(e),
      ));
    }
  }
}
