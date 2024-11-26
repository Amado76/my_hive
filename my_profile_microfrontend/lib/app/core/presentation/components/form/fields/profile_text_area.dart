import 'package:flutter/material.dart';

class ProfileTextArea extends StatelessWidget {
  const ProfileTextArea({super.key, required this.label, this.controller});

  final String label;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: 3,
      maxLines: 5,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]!),
        alignLabelWithHint: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[350]!, width: 1.0),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[350]!, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        errorStyle:
            const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      cursorColor: Colors.grey[600]!,
    );
  }
}
