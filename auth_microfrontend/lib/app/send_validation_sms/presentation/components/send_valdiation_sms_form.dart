import 'package:flutter/material.dart';
import 'package:auth_microfrontend/app/core/presentation/components/phone_number_form_field.dart';
import 'package:auth_microfrontend/app/send_validation_sms/presentation/bloc/send_validation_sms_bloc.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:common_microfrontend/util/validation/validation_mixin.dart';

class SendValidationSmsForm extends StatefulWidget {
  const SendValidationSmsForm(
      {super.key, required this.authTextColor, required this.isoCode});
  final Color authTextColor;
  final String? isoCode;
  @override
  State<SendValidationSmsForm> createState() => SendValidationSmsFormState();
}

class SendValidationSmsFormState extends State<SendValidationSmsForm>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _dialCodeController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _dialCodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sendValidationSmsBloc = Modular.get<SendValidationSmsBloc>();
    final Translation translation = Modular.get<Translation>();

    return Form(
        key: _formKey,
        child: Column(
          children: [
            PhoneNumberFormField(
              isoCode: widget.isoCode,
              authTextColor: widget.authTextColor,
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
              height: 15,
            ),
            CustomElevatedButton(
              text: translation.translate(
                  package: 'authentication', key: 'enviar'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  sendValidationSmsBloc.add(SendVerificationCodeToPhone(
                    phoneNumber: _phoneNumberController.text,
                    dialCode: _dialCodeController.text,
                  ));
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ReturnToLogin(
                  widget.authTextColor,
                ),
              ],
            ),
          ],
        ));
  }
}

class _ReturnToLogin extends StatelessWidget {
  const _ReturnToLogin(this.authTextColor);
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
            translation.translate(
                package: 'authentication', key: 'returnToLoginPage'),
            style: TextStyle(color: authTextColor),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
