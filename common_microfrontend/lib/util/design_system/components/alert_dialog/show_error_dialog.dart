import 'package:flutter/material.dart';
import 'package:common_microfrontend/util/design_system/components/alert_dialog/default_alert_dialog_action_button.dart';
import 'package:common_microfrontend/util/design_system/components/alert_dialog/generate_alert_dialog.dart';
import 'package:common_microfrontend/util/theme_and_colors/presentation/widgets/theme_mode_color_extension.dart';

Future<T?> showErrorDialog<T>({
  required BuildContext context,
  required String title,
  required String contentText,
  Widget? customAction,
  bool? barrierDismissible,
}) {
  final themeMode = Theme.of(context).extension<ThemeModeColorExtension>();
  return generateAlertDialog(
    context: context,
    title: title,
    content: _Content(
      contentText: contentText,
    ),
    backgroundColor: themeMode!.backgroundColor,
    titleTextColor: themeMode.textColor,
    actions: customAction ?? DefaultAlertDialogActionButton(),
    imageTitle: Image.asset(
      'assets/icons/error_icon.png',
      package: 'common_microfrontend',
      width: 40,
    ),
    barrierDismissible: barrierDismissible ?? false,
  );
}

class _Content extends StatelessWidget {
  const _Content({required this.contentText});
  final String contentText;

  @override
  Widget build(BuildContext context) {
    final themeMode = Theme.of(context).extension<ThemeModeColorExtension>();
    return Text(
      textAlign: TextAlign.center,
      contentText,
      style: TextStyle(
        leadingDistribution: TextLeadingDistribution.proportional,
        color: themeMode!.textColor,
        fontSize: 16,
      ),
    );
  }
}
