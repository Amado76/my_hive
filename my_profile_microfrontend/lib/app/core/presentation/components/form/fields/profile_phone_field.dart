import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class ProfilePhoneField extends StatelessWidget {
  ProfilePhoneField({
    super.key,
    required this.label,
    required this.isoCode,
    this.initialValue,
    this.controller,
    this.validator,
  });

  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? initialValue;
  final String? isoCode;

  final Translation translation = Modular.get<Translation>();

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: (_) {},
      validator: validator,
      textFieldController: controller,
      initialValue:
          PhoneNumber(isoCode: isoCode ?? 'BR', phoneNumber: initialValue),
      formatInput: true,
      searchBoxDecoration: InputDecoration(
        hintText:
            translation.translate(package: 'my_profile', key: 'searchCountry'),
      ),
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        setSelectorButtonAsPrefixIcon: true,
        leadingPadding: 15,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
    );
  }
}
