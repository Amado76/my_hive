import 'package:equatable/equatable.dart';

class AuthUserEntity extends Equatable {
  // static AuthUserEntity? _instance;
  final String? _accessToken;

  const AuthUserEntity({required String? accessToken})
      : _accessToken = accessToken;

  String? get accessToken => _accessToken;

  @override
  List<Object?> get props => [accessToken];
}
