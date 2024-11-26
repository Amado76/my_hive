import 'package:flutter/material.dart';

class CustomPasswordFormField extends StatefulWidget {
  final String hintText;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final TextInputType keyBoardType;
  final Color? borderColor;
  final Color? errorBorderColor;
  final Color? fillColor;
  final Color? textColor;
  final Color? iconColor;

  const CustomPasswordFormField(
      {super.key,
      required this.hintText,
      required this.validator,
      required this.controller,
      this.keyBoardType = TextInputType.text,
      this.borderColor,
      this.errorBorderColor,
      this.fillColor,
      this.textColor,
      this.iconColor});

  @override
  State<CustomPasswordFormField> createState() =>
      _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: widget.keyBoardType,
        controller: widget.controller,
        validator: widget.validator,
        obscureText: obscureText,
        textInputAction: TextInputAction.next,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: widget.textColor ?? Colors.white),
        decoration: InputDecoration(
          errorStyle: TextStyle(
              color: widget.textColor ?? Colors.red,
              fontWeight: FontWeight.bold),
          errorMaxLines: 2,
          fillColor: widget.fillColor ?? Colors.white.withOpacity(0.2),
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: widget.textColor ?? Colors.white),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: widget.borderColor ?? Colors.transparent),
              borderRadius: const BorderRadius.all(Radius.circular(50))),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: widget.borderColor ?? Colors.transparent),
              borderRadius: const BorderRadius.all(Radius.circular(50))),
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: widget.errorBorderColor ?? Colors.red),
              borderRadius: const BorderRadius.all(Radius.circular(50))),
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: widget.borderColor ?? Colors.transparent),
              borderRadius: const BorderRadius.all(Radius.circular(50))),
          suffixIcon: IconButton(
            icon: obscureText
                ? Icon(Icons.visibility_off_outlined,
                    color: widget.iconColor ?? Colors.white)
                : Icon(Icons.visibility_outlined,
                    color: widget.iconColor ?? Colors.white),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
          prefixIcon: obscureText
              ? Icon(Icons.lock_outline,
                  color: widget.iconColor ?? Colors.white)
              : Icon(Icons.lock_open_outlined,
                  color: widget.iconColor ?? Colors.white),
        ));
  }
}
