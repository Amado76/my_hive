import 'package:flutter/material.dart';

class ProfilePasswordField extends StatefulWidget {
  const ProfilePasswordField({
    super.key,
    required this.label,
    this.controller,
    this.validator,
  });

  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<StatefulWidget> createState() => _ProfilePasswordFieldState();
}

class _ProfilePasswordFieldState extends State<ProfilePasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      cursorColor: Colors.grey[600]!,
    );
  }
}
