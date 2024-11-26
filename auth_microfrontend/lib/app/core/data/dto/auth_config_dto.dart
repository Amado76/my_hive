import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class AuthConfigDto extends Equatable {
  final Color authTextColor;
  final Color? authSignUpButtonColor,
      authSignUpButtonTextColor,
      authLoginButtonColor,
      authLoginTextColor;
  final String? isoCode;

  const AuthConfigDto({
    required this.authTextColor,
    this.authSignUpButtonColor,
    this.authSignUpButtonTextColor,
    this.authLoginButtonColor,
    this.authLoginTextColor,
    this.isoCode,
  });

  @override
  List<Object?> get props => [
        authTextColor,
        authSignUpButtonColor,
        authSignUpButtonTextColor,
        authLoginButtonColor,
        authLoginTextColor,
        isoCode,
      ];
}
