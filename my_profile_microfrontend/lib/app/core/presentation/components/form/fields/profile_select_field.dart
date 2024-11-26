import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class ProfileSelectField extends StatelessWidget {
  const ProfileSelectField({
    super.key,
    required this.label,
    required this.items,
    this.hint,
    this.validator,
    this.onChanged,
    this.controller,
  });

  final String label;
  final String? Function(String?)? validator;
  final ValueChanged<String?>? onChanged;
  final Map<String, String> items;
  final String? hint;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      onChanged: (value) {
        controller?.text = value!;
      },
      value: items.containsKey(controller?.text) ? controller?.text : null,
      buttonStyleData: const ButtonStyleData(
        width: double.infinity,
        padding: EdgeInsets.only(left: 2),
      ),
      dropdownStyleData: const DropdownStyleData(
        decoration: BoxDecoration(
            // color: Color(0xFFF4F4F4),
            ),
      ),
      decoration: InputDecoration(
        labelText: label,
        // labelStyle: TextStyle(color: Colors.grey[600]!),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.grey[350]!, width: 1.0),
        //   borderRadius: BorderRadius.circular(8),
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.grey[350]!, width: 1.0),
        // ),
        // focusedErrorBorder: OutlineInputBorder(
        //   borderSide: const BorderSide(color: Colors.red),
        //   borderRadius: BorderRadius.circular(8),
        // ),
        // errorStyle:
        //     const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        // errorBorder: OutlineInputBorder(
        //   borderSide: const BorderSide(color: Colors.red),
        //   borderRadius: BorderRadius.circular(8),
        // ),
        // filled: true,
        // fillColor: Colors.white,
      ),
      hint: hint != null ? Text(hint!) : null,
      items: items.entries
          .map((item) =>
              DropdownMenuItem(value: item.key, child: Text(item.value)))
          .toList(),
    );
  }
}
