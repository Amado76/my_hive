import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class PermissionErrorDialog extends StatelessWidget {
  PermissionErrorDialog({
    super.key,
  });

  final Translation translation = Modular.get<Translation>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: Colors.grey,
          height: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: BottomActionButton(
                text: translation.translate(
                  package: 'authentication',
                  key: 'close',
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
            Flexible(
              child: BottomActionButton(
                text: translation.translate(
                  package: 'authentication',
                  key: 'givePermission',
                ),
                onTap: () {
                  AppSettings.openAppSettings(type: AppSettingsType.settings);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BottomActionButton extends StatelessWidget {
  const BottomActionButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onTap(),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
