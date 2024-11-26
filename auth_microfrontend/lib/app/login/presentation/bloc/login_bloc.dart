import 'package:flutter/foundation.dart' show immutable;
import 'package:auth_microfrontend/app/core/domain/use_case/login_with_phone_number_use_case.dart';
import 'package:auth_microfrontend/app/core/util/auth_error.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required LoginWithPhoneNumberUseCase loginWithPhoneNumberUseCase,
    required SaveUserTokenUseCase saveUserTokenUseCase,
    required GeneralConfig gc,
  })  : _loginWithPhoneNumberUseCase = loginWithPhoneNumberUseCase,
        _saveUserTokenUseCase = saveUserTokenUseCase,
        _gc = gc,
        super(LoginIdle()) {
    on<LoginWithPhoneNumber>(_onLoginWithPhoneNumber);
  }

  final LoginWithPhoneNumberUseCase _loginWithPhoneNumberUseCase;
  final SaveUserTokenUseCase _saveUserTokenUseCase;
  final GeneralConfig _gc;

  void _onLoginWithPhoneNumber(
      LoginWithPhoneNumber event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final String authToken = await _loginWithPhoneNumberUseCase(
        phoneNumber: event.phoneNumber,
        password: event.password,
      );
      await _saveUserTokenUseCase(authToken);
      await _gc.init();
      emit(LoginSuccess());
    } on Exception catch (e) {
      emit(LoginError(authError: AuthError.from(e)));
    }
  }
}
