import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({
    super.key,
    required this.label,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      onChanged: (value) => onChanged != null ? onChanged!(value) : {},
      decoration: InputDecoration(
        labelText: label,
      ),
      cursorColor: Colors.grey[600]!,
    );
  }
}
