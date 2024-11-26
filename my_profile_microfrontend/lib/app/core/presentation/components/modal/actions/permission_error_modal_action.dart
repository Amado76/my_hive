import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class PermissionErrorModalAction extends StatelessWidget {
  PermissionErrorModalAction({
    super.key,
    required this.leftButtonAction,
    required this.rightButtonAction,
  });

  final Translation translation = Modular.get<Translation>();
  final Function leftButtonAction;
  final Function rightButtonAction;

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
            BottomActionButton(
              text: translation.translate(
                package: 'my_profile',
                key: 'close',
              ),
              onTap: leftButtonAction,
            ),
            BottomActionButton(
              text: translation.translate(
                package: 'my_profile',
                key: 'givePermission',
              ),
              onTap: rightButtonAction,
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
    return Flexible(
      child: TextButton(
        onPressed: () => onTap(),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
