import 'package:appcore/app/dto/app_core_config_dto.dart';
import 'package:common_microfrontend/util/theme_and_colors/domain/util/hex_color.dart';
import 'package:flutter/material.dart';

const String urlBase = '';
const String apiIdOneSignal = "";

const Color textColorApp = Colors.black;
const String themeMode = 'light';
const String token = "";

//dark
// final Color backgroundApp = Color(HexColor.intFromHex('#242424'));
// const Color textColorApp = Colors.white;
// const String themeMode = 'dark';

final AppCoreConfigDto appCoreConfigDto = AppCoreConfigDto(
  background: Color(HexColor.intFromHex('#b27d00')),
  apiIdOneSignal: apiIdOneSignal,
  tokenToExample: token,
);
