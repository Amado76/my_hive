import 'package:flutter/material.dart';
import 'package:auth_microfrontend/app/core/data/dto/auth_config_dto.dart';
import 'package:auth_microfrontend/app/login/presentation/bloc/login_bloc.dart';
import 'package:auth_microfrontend/app/core/presentation/components/phone_number_form_field.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

import 'package:common_microfrontend/util/validation/validation_mixin.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.authConfigDto,
  });

  final AuthConfigDto authConfigDto;

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dialCodeController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _dialCodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = Modular.get<LoginBloc>();
    final Translation translation = Modular.get<Translation>();

    return Form(
        key: _formKey,
        child: Column(
          children: [
            PhoneNumberFormField(
              authTextColor: widget.authConfigDto.authTextColor,
              isoCode: widget.authConfigDto.isoCode,
              phoneNumberController: _phoneNumberController,
              dialCodeController: _dialCodeController,
              validator: (phone) {
                return combine([
                  () => isNotNull(phone),
                  () => isNotEmpty(phone),
                ]);
              },
            ),
            const SizedBox(
              height: 11,
            ),
            CustomPasswordFormField(
              fillColor: widget.authConfigDto.authTextColor.withOpacity(0.2),
              textColor: widget.authConfigDto.authTextColor,
              iconColor: widget.authConfigDto.authTextColor,
              hintText: translation.translate(
                  package: 'authentication', key: 'password'),
              controller: _passwordController,
              validator: (password) {
                String? result = combine([
                  () => isNotNull(password),
                  () => isNotEmpty(password),
                ]);
                return result;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _ForgotPassword(
                  widget.authConfigDto.authTextColor,
                )
              ],
            ),
            BlocBuilder<LoginBloc, LoginState>(
              bloc: loginBloc,
              builder: (context, state) {
                if (state is LoginLoading) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent.withOpacity(0.6),
                          minimumSize: const Size(400, 56),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed: () {},
                      child: const CircularProgressIndicator(
                        color: Colors.black,
                      ));
                }

                return CustomElevatedButton(
                  backgroundColor: widget.authConfigDto.authLoginButtonColor,
                  textColor: widget.authConfigDto.authLoginTextColor,
                  text: translation.translate(
                      package: 'authentication', key: 'loginSignin'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      loginBloc.add(LoginWithPhoneNumber(
                          phoneNumber: _phoneNumberController.text,
                          password: _passwordController.text));
                    }
                  },
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_Register()],
            ),
          ],
        ));
  }
}

class _ForgotPassword extends StatelessWidget {
  const _ForgotPassword(this.authTextColor);
  final Color authTextColor;

  @override
  Widget build(BuildContext context) {
    final Translation translation = Modular.get<Translation>();
    return TextButton(
      onPressed: () {
        Modular.to.pushNamed(Modular.get<NavigationInjector>().getRelativePath(
            package: 'authentication', pathKey: 'reset_password'));
      },
      child: Text(
        translation.translate(
            package: 'authentication', key: 'loginForgotPassword'),
        style: TextStyle(
          color: authTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _Register extends StatelessWidget {
  const _Register();

  @override
  Widget build(BuildContext context) {
    final Translation translation = Modular.get<Translation>();
    return TextButton(
      onPressed: () {
        Modular.to.pushNamed(Modular.get<NavigationInjector>().getRelativePath(
            package: 'authentication', pathKey: 'send_validation_sms_page'));
      },
      child: Row(
        children: [
          Text(
            translation.translate(
                package: 'authentication', key: 'loginDontHaveAccount'),
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
          const SizedBox(width: 5),
          Text(
            translation.translate(
                package: 'authentication', key: 'loginSignup'),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
