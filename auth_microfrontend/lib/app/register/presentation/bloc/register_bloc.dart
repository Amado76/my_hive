import 'package:flutter/foundation.dart' show immutable;
import 'package:auth_microfrontend/app/core/domain/use_case/register_use_case.dart';
import 'package:auth_microfrontend/app/core/util/auth_error.dart';
import 'package:auth_microfrontend/app/core/util/auth_sucess.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

part 'register_state.dart';
part 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required RegisterUseCase registerUseCase,
    required SaveUserTokenUseCase saveUserTokenUseCase,
  })  : _registerUseCase = registerUseCase,
        _saveUserTokenUseCase = saveUserTokenUseCase,
        super(RegisterIdle()) {
    on<RegisterNewUser>(_onRegisterNewUser);
    on<RegisterChangeAvatar>(_onRegisterChangeAvatar);
  }

  final RegisterUseCase _registerUseCase;
  final SaveUserTokenUseCase _saveUserTokenUseCase;

  void _onRegisterNewUser(
      RegisterNewUser event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      final String authToken = await _registerUseCase(
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
        phoneNumber: event.phoneNumber,
        cpf: event.cpf,
        image: event.image,
        classCode: event.classCode,
      );
      await _saveUserTokenUseCase(authToken);
      emit(RegisterSuccess(authSuccess: AuthSuccessUnknown()));
    } on Exception catch (e) {
      emit(RegisterError(authError: AuthError.from(e)));
    }
  }

  void _onRegisterChangeAvatar(
      RegisterChangeAvatar event, Emitter<RegisterState> emit) {
    emit(RegisterChangedAvatar(image: event.image));
  }
}
