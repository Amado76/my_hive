import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class UserNameHomeWidget extends StatelessWidget {
  const UserNameHomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GeneralConfig generalConfig = Modular.get<GeneralConfig>();
    final size = MediaQuery.sizeOf(context);
    final Color primaryColor = Theme.of(context).primaryColor;
    return Container(
      width: size.width * 0.4,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: const Color(0xFF000000).withOpacity(1),
          offset: const Offset(0, 0),
          blurRadius: 8,
          spreadRadius: -6,
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Text(
                generalConfig.userEntity!.fullName ?? '',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserNameHomeLoadingWidget extends StatelessWidget {
  const UserNameHomeLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
          width: size.width * 0.4,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          child: const Text('')),
    );
  }
}
