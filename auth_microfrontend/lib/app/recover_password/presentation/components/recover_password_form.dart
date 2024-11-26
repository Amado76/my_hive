import 'package:flutter/material.dart';
import 'package:auth_microfrontend/app/recover_password/presentation/bloc/recover_password_bloc.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:common_microfrontend/util/validation/email_validation_mixin.dart';
import 'package:common_microfrontend/util/validation/validation_mixin.dart';

class RecoverPasswordForm extends StatefulWidget {
  const RecoverPasswordForm({super.key, required this.authTextColor});
  final Color authTextColor;

  @override
  State<RecoverPasswordForm> createState() => _RecoverPasswordFormState();
}

class _RecoverPasswordFormState extends State<RecoverPasswordForm>
    with ValidationMixin, EmailValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recoverPasswordBloc = Modular.get<RecoverPasswordBloc>();
    final Translation translation = Modular.get<Translation>();

    return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField(
              textColor: widget.authTextColor,
              fillColor: widget.authTextColor.withOpacity(0.2),
              hintText: translation.translate(
                  package: 'authentication', key: 'email'),
              controller: _emailController,
              validator: (email) {
                String? result = combine([
                  () => isNotNull(email),
                  () => isNotEmpty(email),
                  () => isValidEmail(email!),
                ]);
                return result;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            CustomElevatedButton(
              text: translation.translate(
                  package: 'authentication', key: 'enviar'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  recoverPasswordBloc.add(SendResetPasswordEmail(
                      email: _emailController.text.trim()));
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Login(
                  widget.authTextColor,
                )
              ],
            ),
          ],
        ));
  }
}

class _Login extends StatelessWidget {
  const _Login(this.authTextColor);
  final Color authTextColor;
  @override
  Widget build(BuildContext context) {
    final Translation translation = Modular.get<Translation>();
    return TextButton(
      onPressed: () {
        Modular.to.pop();
      },
      child: Row(
        children: [
          Text(
            translation.translate(package: 'authentication', key: 'login'),
            style: TextStyle(color: authTextColor, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
