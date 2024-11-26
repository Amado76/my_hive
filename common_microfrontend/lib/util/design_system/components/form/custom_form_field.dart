import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String? Function(String?) validator;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyBoardType;
  final Widget? icon;
  final String? initialValue;
  final Color? borderColor;
  final Color? errorBorderColor;
  final Color? fillColor;
  final Color? textColor;

  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.validator,
      this.obscureText = false,
      required this.controller,
      this.keyBoardType = TextInputType.text,
      this.icon,
      this.initialValue,
      this.borderColor,
      this.errorBorderColor,
      this.fillColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyBoardType,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      textInputAction: TextInputAction.next,
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: textColor ?? Colors.white),
      decoration: InputDecoration(
        errorMaxLines: 2,
        fillColor: fillColor ?? Colors.white.withOpacity(0.2),
        filled: true,
        hintText: hintText,
        prefixIcon: icon,
        hintStyle: TextStyle(color: textColor ?? Colors.white),
        errorStyle: TextStyle(
            color: errorBorderColor ?? Colors.red, fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? Colors.transparent),
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? Colors.transparent),
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? Colors.transparent),
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: errorBorderColor ?? Colors.red,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(50))),
      ),
    );
  }
}
