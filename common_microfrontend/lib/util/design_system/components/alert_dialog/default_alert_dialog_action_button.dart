import 'package:common_microfrontend/util/translation/domain/entity/translation.dart';
import 'package:flutter/material.dart';

import 'package:common_microfrontend/util/theme_and_colors/presentation/widgets/theme_mode_color_extension.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DefaultAlertDialogActionButton extends StatelessWidget {
  DefaultAlertDialogActionButton({super.key});
  final Translation translation = Modular.get<Translation>();

  @override
  Widget build(BuildContext context) {
    final themeMode = Theme.of(context).extension<ThemeModeColorExtension>();
    return Column(
      children: [
        const Divider(
          color: Colors.grey,
          height: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  translation.translate(
                      package: "common", key: "alertDialogClose"),
                  style: TextStyle(
                    color: themeMode!.textColor,
                    fontSize: 16,
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
