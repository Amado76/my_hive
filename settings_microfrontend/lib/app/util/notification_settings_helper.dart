import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class NotificationSettingsHelper {
  static Future<void> openNotificationSettings(BuildContext context) async {
    if (Theme.of(context).platform == TargetPlatform.android) {
      const OpenSettingsPlusAndroid().applicationDetails();
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      const OpenSettingsPlusIOS().settings();
    } else {
      throw GTecException(message: "unsupportedPlatform");
    }
  }
}
