import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class ChoosePictureModalAction extends StatelessWidget {
  ChoosePictureModalAction({
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
            Flexible(
              child: ChoosePictureBottomButton(
                text: translation.translate(
                  package: 'my_profile',
                  key: 'takePicture',
                ),
                onTap: leftButtonAction,
              ),
            ),
            Flexible(
              child: ChoosePictureBottomButton(
                text: translation.translate(
                  package: 'my_profile',
                  key: 'pickFromGallery',
                ),
                onTap: rightButtonAction,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ChoosePictureBottomButton extends StatelessWidget {
  const ChoosePictureBottomButton({
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
