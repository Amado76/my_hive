import 'package:appcore/app/dto/app_core_config_dto.dart';
import 'package:common_microfrontend/util/theme_and_colors/domain/util/hex_color.dart';
import 'package:flutter/material.dart';

const String urlBase = '';
const String apiIdOneSignal = "";

const Color textColorApp = Colors.black;
const String themeMode = 'light';
const String token =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNDc5MjAsInVzZXJuYW1lIjoiYnJ1bm9hbWFkb0BnbWFpbC5jb20iLCJleHAiOjE3MzE5ODY4MTAsImVtYWlsIjoiYnJ1bm9hbWFkb0BnbWFpbC5jb20ifQ.PPf60UIF6myM3rMcdV1xqbJb6AQp2Smb1UtwhDNQ4x0";

//dark
// final Color backgroundApp = Color(HexColor.intFromHex('#242424'));
// const Color textColorApp = Colors.white;
// const String themeMode = 'dark';

final AppCoreConfigDto appCoreConfigDto = AppCoreConfigDto(
  background: Color(HexColor.intFromHex('#b27d00')),
  apiIdOneSignal: apiIdOneSignal,
  tokenToExample: token,
);
