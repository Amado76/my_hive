import 'package:flutter/material.dart';
import 'package:auth_microfrontend/app/recover_password/presentation/bloc/recover_password_bloc.dart';
import 'package:auth_microfrontend/app/recover_password/presentation/components/recover_password_form.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key, required this.authTextColor});
  final Color authTextColor;

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final RecoverPasswordBloc recoverPasswordBloc =
        Modular.get<RecoverPasswordBloc>();
    final Translation translation = Modular.get<Translation>();
    final size = MediaQuery.sizeOf(context);

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
          body: BlocListener<RecoverPasswordBloc, RecoverPasswordState>(
            bloc: recoverPasswordBloc,
            listener: (context, state) {
              switch (state) {
                case RecoverPasswordIdle():
                  break;
                case RecoverPasswordLoading():
                  //todo: show loading
                  break;
                case RecoverPasswordError():
                  showErrorDialog(
                    context: context,
                    title: state.authError.dialogTitle,
                    contentText: state.authError.dialogText,
                  );
                  break;
                case RecoverPasswordSuccess():
                  showSuccessDialog(
                    context: context,
                    title: state.authSuccess.dialogTitle,
                    contentText: state.authSuccess.dialogText,
                  );

                  break;
              }
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 35),
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.3,
                          child: Image.asset("assets/images/logo.png",
                              alignment: Alignment.center),
                        ),
                        const SizedBox(height: 50),
                        Text(
                          translation.translate(
                              package: 'authentication',
                              key: 'recoverPasswordTitle'),
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: widget.authTextColor),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          textAlign: TextAlign.center,
                          translation.translate(
                              package: 'authentication',
                              key: 'recoverPasswordSubtitle'),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: widget.authTextColor),
                        ),
                        SizedBox(height: size.height * 0.10),
                        RecoverPasswordForm(
                          authTextColor: widget.authTextColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
