import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class ProfileTextAreaShimmer extends StatelessWidget {
  const ProfileTextAreaShimmer({
    super.key,
    this.minLines = 3,
    this.maxLines = 5,
  });

  final int minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: TextField(
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
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
      ),
    );
  }
}
