import 'package:flutter/foundation.dart' show immutable;
import 'package:auth_microfrontend/app/core/domain/use_case/reset_password_use_case.dart';
import 'package:auth_microfrontend/app/core/util/auth_error.dart';
import 'package:auth_microfrontend/app/core/util/auth_sucess.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

part 'recover_password_state.dart';
part 'recover_password_event.dart';

class RecoverPasswordBloc
    extends Bloc<RecoverPasswordEvent, RecoverPasswordState> {
  RecoverPasswordBloc({
    required ResetPasswordUseCase resetPasswordUseCase,
  })  : _resetPasswordUseCase = resetPasswordUseCase,
        super(RecoverPasswordIdle()) {
    on<SendResetPasswordEmail>(_onSendResetPasswordEmail);
  }

  final ResetPasswordUseCase _resetPasswordUseCase;

  void _onSendResetPasswordEmail(
      SendResetPasswordEmail event, Emitter<RecoverPasswordState> emit) async {
    emit(RecoverPasswordLoading());
    try {
      final email = event.email;
      final String result = await _resetPasswordUseCase(email: email);
      emit(RecoverPasswordSuccess(authSuccess: AuthSuccess.from(result)));
    } on Exception catch (e) {
      emit(RecoverPasswordError(authError: AuthError.from(e)));
    }
  }
}
