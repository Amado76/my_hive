import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class ProfileSubmitButtonShimmer extends StatelessWidget {
  const ProfileSubmitButtonShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          backgroundColor: const Color(0xFFDA303B),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(
            fontSize: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: const Text(
          '',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
