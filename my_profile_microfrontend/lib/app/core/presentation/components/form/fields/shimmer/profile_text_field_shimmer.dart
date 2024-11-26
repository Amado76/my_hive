import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class ProfileTextFieldShimmer extends StatelessWidget {
  const ProfileTextFieldShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: TextField(
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.grey[600]!),
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
      ),
    );
  }
}
