import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auth_microfrontend/app/phone_validation/presentation/bloc/phone_validation_bloc.dart';
import 'package:auth_microfrontend/app/send_validation_sms/presentation/bloc/send_validation_sms_bloc.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class PhoneValidationForm extends StatefulWidget {
  const PhoneValidationForm({super.key, required this.authTextColor});
  final Color authTextColor;

  @override
  State<PhoneValidationForm> createState() => _PhoneValidationFormState();
}

class _PhoneValidationFormState extends State<PhoneValidationForm> {
  List<TextEditingController> _codeControllers = [];
  final int codeLength = 6;
  @override
  void initState() {
    super.initState();

    _codeControllers =
        List.generate(codeLength, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildCodeFormField({
    required int index,
  }) {
    PhoneValidationBloc phoneValidationBloc =
        Modular.get<PhoneValidationBloc>();
    return SizedBox(
      height: 50,
      width: 48,
      child: TextFormField(
        controller: _codeControllers[index],
        autofocus: index == 0,
        onChanged: (value) {
          _handleInputValueChange(value, index, context, codeLength,
              _codeControllers, phoneValidationBloc);
        },
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: widget.authTextColor,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          filled: true,
          fillColor: widget.authTextColor.withOpacity(0.2),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          errorStyle: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<Widget>.generate(
          codeLength,
          (index) => _buildCodeFormField(index: index),
        ),
      ),
    );
  }
}

void _handleInputValueChange(
    String value,
    int index,
    BuildContext context,
    int codeLength,
    List<TextEditingController> codeControllers,
    PhoneValidationBloc phoneValidationBloc) {
  _handleSingleDigitInput(index, context, codeLength, value.length);
  _handleEmptyInput(index, context, value);
  _handleSubmitCode(
      context, codeControllers, phoneValidationBloc, value, index, codeLength);
}

void _handleSingleDigitInput(
    int index, BuildContext context, int codeLength, int valueLength) {
  if (valueLength == 1 && index < codeLength - 1) {
    FocusScope.of(context).nextFocus();
  }
}

void _handleEmptyInput(int index, BuildContext context, String value) {
  if (value.isEmpty && index > 0) {
    FocusScope.of(context).previousFocus();
  } else if (value.isEmpty && index == 0) {
    FocusScope.of(context).unfocus();
  }
}

void _handleSubmitCode(
    BuildContext context,
    List<TextEditingController> codeControllers,
    PhoneValidationBloc phoneValidationBloc,
    String value,
    int index,
    int codeLength) {
  final SendValidationSmsBloc sendValidationSmsBloc =
      Modular.get<SendValidationSmsBloc>();
  final phoneNumber = sendValidationSmsBloc.state.phoneNumber ?? '';
  final dialCode = sendValidationSmsBloc.state.dialCode ?? '';
  if (value.isNotEmpty && index == codeLength - 1) {
    String fullCode = codeControllers.map((e) => e.text).join();
    phoneValidationBloc.add(VerifyPhoneWithCode(
        token: fullCode, phoneNumber: phoneNumber, dialCode: dialCode));
    FocusScope.of(context).unfocus();
    _clearCodeControllers(codeControllers);
  }
}

void _clearCodeControllers(List<TextEditingController> codeControllers) {
  for (var controller in codeControllers) {
    controller.clear();
  }
}
