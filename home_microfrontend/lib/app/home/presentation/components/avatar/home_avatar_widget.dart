// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:home_microfrontend/app/home/presentation/components/user_name_home_widget.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class HomeAvatarWidget extends StatelessWidget {
  const HomeAvatarWidget({
    super.key,
    required this.avatarPath,
  });
  final String? avatarPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: NetworkImage(avatarPath ?? ''),
          ),
          const SizedBox(height: 10),
          const UserNameHomeWidget(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class HomeAvatarLoadingWidget extends StatelessWidget {
  const HomeAvatarLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[350]!,
          highlightColor: Colors.grey[100]!,
          child: const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey,
            ),
          ),
        )
      ],
    );
  }
}
