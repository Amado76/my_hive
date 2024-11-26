import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auth_microfrontend/app/phone_validation/presentation/bloc/phone_validation_bloc.dart';
import 'package:auth_microfrontend/app/register/presentation/bloc/register_bloc.dart';
import 'package:auth_microfrontend/app/register/presentation/components/permission_error_dialog.dart';
import 'package:auth_microfrontend/app/register/presentation/components/register_form.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.authTextColor});
  final Color authTextColor;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static PhoneValidationBloc phoneValidationBloc =
      Modular.get<PhoneValidationBloc>();
  final String phoneNumber = phoneValidationBloc.state.phoneNumber ?? '';
  @override
  Widget build(BuildContext context) {
    final RegisterBloc registerBloc = Modular.get<RegisterBloc>();

    final Translation translation = Modular.get<Translation>();
    final Size size = MediaQuery.sizeOf(context);
    // final ImagePicker imagePicker = ImagePicker();
    XFile? xFileImage;
    // String? imagePath;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/background.png"),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocListener<RegisterBloc, RegisterState>(
              bloc: registerBloc,
              listener: (context, state) {
                switch (state) {
                  case RegisterSuccess():
                    Modular.to.navigate(Modular.get<NavigationInjector>()
                        .getPath(package: 'baseapp', pathKey: 'home'));
                    break;
                  case RegisterError():
                    showErrorDialog(
                        context: context,
                        title: state.authError.dialogTitle,
                        contentText: state.authError.dialogText);
                    break;
                  case RegisterChangedAvatar():
                    // imagePath = state.image?.path;
                    xFileImage = state.image;
                    break;
                  case RegisterLoading():
                    //todo: implement loading
                    break;
                  case RegisterIdle():
                    break;
                }
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 35),
                    child: SizedBox(
                      child: Column(
                        children: [
                          SizedBox(height: size.height * 0.01),
                          Text(
                            translation.translate(
                                package: 'authentication',
                                key: 'registerTitle'),
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: widget.authTextColor),
                          ),
                          const SizedBox(height: 10),
                          BlocBuilder<RegisterBloc, RegisterState>(
                            bloc: registerBloc,
                            builder: (context, state) {
                              return Container();
                            },
                          ),
                          SizedBox(height: size.height * 0.05),
                          RegisterForm(
                            authTextColor: widget.authTextColor,
                            phoneNumber: phoneNumber,
                            avatarImage: xFileImage,
                          ),
                          SizedBox(height: size.height * 0.05),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Future<dynamic> _editPhotoDetail(
      {required BuildContext context,
      required Translation translation,
      required XFile? xFileImage,
      required ImagePicker imagePicker,
      required RegisterBloc registerBloc}) {
    return showDefaultDialog(
        barrierDismissible: true,
        context: context,
        title: translation.translate(
            package: 'authentication', key: 'registerAlertDialogTitle'),
        contentText: translation.translate(
            package: 'authentication', key: 'registerAlertDialogMessage'),
        customAction: Column(
          children: [
            const Divider(
              color: Colors.grey,
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () async {
                      try {
                        xFileImage = await imagePicker.pickImage(
                            source: ImageSource.camera);
                        registerBloc
                            .add(RegisterChangeAvatar(image: xFileImage));
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      } on PlatformException {
                        if (context.mounted) {
                          Navigator.of(context).pop();
                          showErrorDialog(
                              context: context,
                              title: translation.translate(
                                  package: "authentication",
                                  key: "permissionDenied"),
                              contentText: translation.translate(
                                  package: "authentication",
                                  key: "permissionDeniedCameraMessage"),
                              customAction: PermissionErrorDialog());
                        }
                      }
                    },
                    child: Text(
                      translation.translate(
                          package: "authentication", key: "registerTakePhoto"),
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )),
                TextButton(
                    onPressed: () async {
                      try {
                        xFileImage = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        registerBloc
                            .add(RegisterChangeAvatar(image: xFileImage));
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      } on PlatformException {
                        if (context.mounted) {
                          Navigator.of(context).pop();
                          showErrorDialog(
                              context: context,
                              title: translation.translate(
                                  package: "authentication",
                                  key: "permissionDenied"),
                              contentText: translation.translate(
                                  package: "authentication",
                                  key: "permissionDeniedGalleryMessage"),
                              customAction: PermissionErrorDialog());
                        }
                      }
                    },
                    child: Text(
                      translation.translate(
                          package: "authentication",
                          key: "registerChooseFromGallery"),
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )),
              ],
            ),
          ],
        ));
  }
}
