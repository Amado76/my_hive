part of 'register_bloc.dart';

@immutable
sealed class RegisterState extends Equatable {
  const RegisterState();
}

@immutable
class RegisterIdle extends RegisterState {
  @override
  List<Object?> get props => [];
}

@immutable
class RegisterChangedAvatar extends RegisterState {
  const RegisterChangedAvatar({required this.image});

  final XFile? image;
  @override
  List<Object?> get props => [image];
}

@immutable
class RegisterLoading extends RegisterState {
  @override
  List<Object?> get props => [];
}

@immutable
class RegisterError extends RegisterState {
  const RegisterError({required this.authError});
  final AuthError authError;
  @override
  List<Object?> get props => [authError];
}

@immutable
class RegisterSuccess extends RegisterState {
  final AuthSuccess authSuccess;
  const RegisterSuccess({
    required this.authSuccess,
  });
  @override
  List<Object?> get props => [authSuccess];
}

extension GetXFileImage on RegisterState {
  XFile? get image {
    final state = this;
    if (state is RegisterChangedAvatar) {
      return state.image;
    }
    return null;
  }
}
