import 'package:flutter/material.dart';
import 'package:common_microfrontend/util/design_system/components/alert_dialog/default_alert_dialog_action_button.dart';
import 'package:common_microfrontend/util/design_system/components/alert_dialog/generate_alert_dialog.dart';
import 'package:common_microfrontend/util/theme_and_colors/presentation/widgets/theme_mode_color_extension.dart';

Future<T?> showDefaultDialog<T>({
  required BuildContext context,
  required String title,
  String? contentText,
  Widget? customContentWidget,
  Widget? customAction,
  Image? imageTitle,
  bool? barrierDismissible,
  Color? backgroundColor,
  Color? titleTextColor,
  Color? contentTextColor,
}) {
  final themeMode = Theme.of(context).extension<ThemeModeColorExtension>();
  return generateAlertDialog(
    context: context,
    title: title,
    content: customContentWidget ??
        _Content(
          contentText: contentText ?? '',
          contentTextColor: contentTextColor,
        ),
    backgroundColor: backgroundColor ?? themeMode!.backgroundColor,
    titleTextColor: titleTextColor ?? themeMode!.textColor,
    actions: customAction ?? DefaultAlertDialogActionButton(),
    imageTitle: imageTitle,
    barrierDismissible: barrierDismissible ?? false,
  );
}

class _Content extends StatelessWidget {
  const _Content({required this.contentText, this.contentTextColor});
  final String contentText;
  final Color? contentTextColor;
  @override
  Widget build(BuildContext context) {
    final themeMode = Theme.of(context).extension<ThemeModeColorExtension>();
    return Text(
      textAlign: TextAlign.center,
      contentText,
      style: TextStyle(
        leadingDistribution: TextLeadingDistribution.proportional,
        color: contentTextColor ?? themeMode!.textColor,
        fontSize: 16,
      ),
    );
  }
}
