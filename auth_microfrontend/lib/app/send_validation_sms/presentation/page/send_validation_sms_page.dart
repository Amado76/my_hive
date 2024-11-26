import 'package:flutter/material.dart';
import 'package:auth_microfrontend/app/send_validation_sms/presentation/bloc/send_validation_sms_bloc.dart';
import 'package:auth_microfrontend/app/send_validation_sms/presentation/components/send_valdiation_sms_form.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class SendVaidationSmsPage extends StatefulWidget {
  const SendVaidationSmsPage(
      {super.key, required this.authTextColor, required this.isoCode});
  final Color authTextColor;
  final String? isoCode;
  @override
  State<SendVaidationSmsPage> createState() => _SendVaidationSmsPageState();
}

class _SendVaidationSmsPageState extends State<SendVaidationSmsPage> {
  @override
  Widget build(BuildContext context) {
    final SendValidationSmsBloc sendValidationSmsBloc =
        Modular.get<SendValidationSmsBloc>();
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
          body: BlocListener<SendValidationSmsBloc, SendValidationSmsState>(
            bloc: sendValidationSmsBloc,
            listener: (context, state) {
              switch (state) {
                case SendValidationSmsSuccess():
                  Modular.to.pushNamed(Modular.get<NavigationInjector>()
                      .getPathInPackage(
                          package: 'authentication',
                          pathKey: 'phone_validation'));
                  break;
                case SendValidationSmsErrorState():
                  showErrorDialog(
                    context: context,
                    title: state.sendValidationSmsError.dialogTitle,
                    contentText: state.sendValidationSmsError.dialogText,
                  );
                  break;
                case SendValidationSmsLoading():
                  break;
                default:
                  break;
              }
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 35),
                  child: SizedBox(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.3,
                          child: Image.asset("assets/images/logo.png",
                              alignment: Alignment.center),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          textAlign: TextAlign.center,
                          translation.translate(
                              package: 'authentication',
                              key: 'sendValidationSmsFormTitle'),
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
                              key: 'sendValidationSmsFormSubtitle'),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: widget.authTextColor),
                        ),
                        SizedBox(height: size.height * 0.15),
                        SendValidationSmsForm(
                          isoCode: widget.isoCode,
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
