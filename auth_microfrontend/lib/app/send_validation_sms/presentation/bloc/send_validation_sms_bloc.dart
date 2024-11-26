import 'package:flutter/foundation.dart' show immutable;
import 'package:auth_microfrontend/app/core/domain/use_case/send_verification_code_to_phone_use_case.dart';
import 'package:auth_microfrontend/app/send_validation_sms/util/send_validation_sms_error.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
part 'send_validation_sms_state.dart';
part 'send_validation_sms_event.dart';

class SendValidationSmsBloc
    extends Bloc<SendValidationSmsEvent, SendValidationSmsState> {
  SendValidationSmsBloc({
    required SendVerificationCodeToPhoneUseCase
        sendVerificationCodeToPhoneUseCase,
  })  : _sendVerificationCodeToPhoneUseCase =
            sendVerificationCodeToPhoneUseCase,
        super(SendValidationSmsIdle()) {
    on<SendVerificationCodeToPhone>(_onSendVerificationCodeToPhone);
  }

  final SendVerificationCodeToPhoneUseCase _sendVerificationCodeToPhoneUseCase;

  void _onSendVerificationCodeToPhone(SendVerificationCodeToPhone event,
      Emitter<SendValidationSmsState> emit) async {
    emit(const SendValidationSmsLoading());
    try {
      await _sendVerificationCodeToPhoneUseCase(
          phoneNumber: event.phoneNumber, dialCode: event.dialCode);
      emit(SendValidationSmsSuccess(
          phoneNumber: event.phoneNumber, dialCode: event.dialCode));
    } on Exception catch (e) {
      emit(SendValidationSmsErrorState(
          sendValidationSmsError: SendValidationSmsError.from(e)));
    }
  }
}
