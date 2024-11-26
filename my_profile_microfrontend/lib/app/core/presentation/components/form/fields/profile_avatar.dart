import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_profile_microfrontend/app/core/presentation/components/modal/actions/choose_picture_modal_action.dart';
import 'package:my_profile_microfrontend/app/core/presentation/components/modal/actions/permission_error_modal_action.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({
    super.key,
    this.avatarUrl,
    required this.onChangeAvatar,
  });

  final String? avatarUrl;
  final Function onChangeAvatar;

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 90,
          backgroundImage: selectedImage == null
              ? NetworkImage(widget.avatarUrl ?? '')
              : FileImage(selectedImage!),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(0),
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.white.withOpacity(0.7),
                  size: 29,
                ),
                onPressed: () => editAvatar(context),
              ),
            ),
          ),
        )
      ],
    );

    // return UserAvatar(
    //   image: Image(
    //     fit: BoxFit.cover,
    //     image: selectedImage == null
    //         ? NetworkImage(widget.avatarUrl ?? '')
    //         : FileImage(selectedImage!),
    //   ),
    //   mainHexagonSize: 0,
    //   onDefaultButtonPress: () => editAvatar(context),
    // );
  }

  void editAvatar(BuildContext context) {
    Translation translation = Modular.get<Translation>();

    showDefaultDialog(
      barrierDismissible: true,
      context: context,
      title: translation.translate(package: 'my_profile', key: 'whatToDo'),
      contentText:
          translation.translate(package: 'my_profile', key: 'pickAnOption'),
      customAction: ChoosePictureModalAction(
        leftButtonAction: () => _takePicture(),
        rightButtonAction: () => _pickImageFromGallery(),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    try {
      final galleryImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (galleryImage == null) return;

      setState(() {
        selectedImage = File(galleryImage.path);
        widget.onChangeAvatar(selectedImage);
        Navigator.pop(context);
      });
    } catch (e) {
      if (e is PlatformException && e.code == 'photo_access_denied') {
        _showPermissionErrorDialog();
      }
    }
  }

  Future _takePicture() async {
    try {
      final cameraImage =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (cameraImage == null) return;

      setState(() {
        selectedImage = File(cameraImage.path);
        widget.onChangeAvatar(selectedImage);
        Navigator.pop(context);
      });
    } catch (e) {
      if (e is PlatformException && e.code == 'camera_access_denied') {
        _showPermissionErrorDialog();
      }
    }
  }

  Future<dynamic> _showPermissionErrorDialog() {
    final Translation translation = Modular.get<Translation>();

    return showErrorDialog(
      barrierDismissible: true,
      context: context,
      title: translation.translate(
        package: 'my_profile',
        key: 'pickImagePermissionErrorTitle',
      ),
      contentText: translation.translate(
        package: 'my_profile',
        key: 'pickImageErrorText',
      ),
      customAction: PermissionErrorModalAction(
        leftButtonAction: () => Navigator.pop(context),
        rightButtonAction: () {
          AppSettings.openAppSettings(type: AppSettingsType.settings);
        },
      ),
    );
  }
}
