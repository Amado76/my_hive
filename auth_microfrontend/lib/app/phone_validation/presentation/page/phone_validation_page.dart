import 'dart:async';
import 'package:flutter/material.dart';
import 'package:auth_microfrontend/app/phone_validation/presentation/bloc/phone_validation_bloc.dart';
import 'package:auth_microfrontend/app/phone_validation/presentation/components/phone_validation_form.dart';
import 'package:auth_microfrontend/app/send_validation_sms/presentation/bloc/send_validation_sms_bloc.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class PhoneValidationPage extends StatefulWidget {
  const PhoneValidationPage({super.key, required this.authTextColor});
  final Color authTextColor;

  @override
  State<PhoneValidationPage> createState() => _PhoneValidationPageState();
}

class _PhoneValidationPageState extends State<PhoneValidationPage> {
  static const int maxSecondsToResendCode = 30;
  int secondsToResendCode = maxSecondsToResendCode;
  Timer? timer;
  bool isResendCodeEnabled = true;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (secondsToResendCode == 0) {
          isResendCodeEnabled = true;
          timer?.cancel();
          secondsToResendCode = maxSecondsToResendCode;
        } else {
          secondsToResendCode--;
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SendValidationSmsBloc sendValidationSmsBloc =
        Modular.get<SendValidationSmsBloc>();
    final phoneNumber = sendValidationSmsBloc.state.phoneNumber ?? '';
    final dialCode = sendValidationSmsBloc.state.dialCode ?? '';
    final Translation translation = Modular.get<Translation>();
    final Size size = MediaQuery.sizeOf(context);
    final PhoneValidationBloc phoneValidationBloc =
        Modular.get<PhoneValidationBloc>();

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
          body: BlocListener<PhoneValidationBloc, PhoneValidationState>(
              bloc: phoneValidationBloc,
              listener: (context, state) {
                if (state is PhoneValidationLoading) {}
                if (state is PhoneValidationErrorState) {
                  showErrorDialog(
                    context: context,
                    title: state.phoneValidationError.dialogTitle,
                    contentText: state.phoneValidationError.dialogText,
                  );
                }
                if (state is PhoneValidationSuccess) {
                  Modular.to.pushNamed(Modular.get<NavigationInjector>()
                      .getPathInPackage(
                          package: 'authentication', pathKey: 'register'));
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
                          SizedBox(height: size.height * 0.05),
                          Text(
                            translation.translate(
                                package: 'authentication',
                                key: 'phoneValidationPageTitle'),
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: widget.authTextColor),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            textAlign: TextAlign.center,
                            translation.translate(
                                package: 'authentication',
                                key: 'phoneValidationPageSubtitle',
                                args: [
                                  phoneNumber.trim(),
                                ]),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: widget.authTextColor),
                          ),
                          SizedBox(height: size.height * 0.05),
                          PhoneValidationForm(
                            authTextColor: widget.authTextColor,
                          ),
                          SizedBox(height: size.height * 0.05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Visibility(
                                      visible: isResendCodeEnabled,
                                      child: TextButton(
                                        onPressed: () {
                                          phoneValidationBloc.add(
                                            ResendVerificationCodeToPhone(
                                              phoneNumber: phoneNumber,
                                              dialCode: dialCode,
                                            ),
                                          );
                                          isResendCodeEnabled = false;
                                          startTimer();
                                        },
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          translation.translate(
                                              package: 'authentication',
                                              key:
                                                  'phoneValidationPageResendCode'),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: widget.authTextColor),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: !isResendCodeEnabled,
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          translation.translate(
                                              package: 'authentication',
                                              key:
                                                  'phoneValidationPageResendCodeTimer',
                                              args: [
                                                secondsToResendCode.toString(),
                                              ]),
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w200,
                                            color: widget.authTextColor,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    Modular.to.pop();
                                  },
                                  child: Text(
                                    translation.translate(
                                        package: 'authentication',
                                        key: 'phoneValidationPageChangeNumber'),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: widget.authTextColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
}
