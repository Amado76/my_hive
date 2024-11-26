import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class PhoneNumberFormField extends StatelessWidget {
  final String? Function(String?) validator;
  final TextEditingController phoneNumberController;
  final TextEditingController dialCodeController;
  final String initialValue;
  final Color authTextColor;
  final String? isoCode;

  const PhoneNumberFormField({
    super.key,
    required this.validator,
    required this.phoneNumberController,
    required this.dialCodeController,
    this.initialValue = '',
    required this.authTextColor,
    this.isoCode,
  });

  @override
  Widget build(BuildContext context) {
    final Translation translation = Modular.get<Translation>();
    final PhoneNumber number =
        PhoneNumber(isoCode: isoCode ?? 'BR', phoneNumber: '');

    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
        phoneNumberController.text = number.parseNumber();
        dialCodeController.text = number.dialCode ?? '';
      },
      onInputValidated: (bool value) {},
      validator: validator,
      textFieldController: phoneNumberController,
      initialValue: number,
      formatInput: true,
      searchBoxDecoration: InputDecoration(
        hintText: translation.translate(
            package: 'authentication', key: 'loginSearchCountry'),
      ),
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        setSelectorButtonAsPrefixIcon: true,
        leadingPadding: 15,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      selectorTextStyle: TextStyle(color: authTextColor),
      textStyle: TextStyle(color: authTextColor, fontSize: 18),
      inputDecoration: InputDecoration(
        filled: true,
        fillColor: authTextColor.withOpacity(0.2),
        counterStyle: TextStyle(color: authTextColor, fontSize: 18),
        hintStyle: TextStyle(color: authTextColor, fontSize: 18),
        hintText: translation.translate(
            package: 'authentication', key: 'phoneNumber'),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(50),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(50),
        ),
        errorStyle:
            const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
    );
  }
}
