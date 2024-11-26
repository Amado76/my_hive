import 'package:appcore/app/dto/app_core_config_dto.dart';
import 'package:auth_microfrontend/app/core/data/dto/auth_config_dto.dart';
import 'package:flutter/material.dart';

const String urlBase = 'http://testes.multdata.com.br/';
const String appTitle = "My Hive";

final AuthConfigDto authConfigDto = AuthConfigDto(
  authTextColor: Colors.black,
  authLoginButtonColor: Colors.white,
  authLoginTextColor: Colors.black,
  authSignUpButtonTextColor: Colors.black,
  authSignUpButtonColor: Colors.white.withOpacity(0.7),
);

final AppCoreConfigDto appCoreConfigDto = AppCoreConfigDto(
    background: Colors.blueAccent.withOpacity(0.6),
    apiIdOneSignal: "e8d43490-a7aa-4899-830a-2b0a2173ba57",
    themeMode: 'light');
