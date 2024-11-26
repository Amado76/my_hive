import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class ProfileAvatarShimmer extends StatefulWidget {
  const ProfileAvatarShimmer({super.key});

  @override
  State<ProfileAvatarShimmer> createState() => _ProfileAvatarShimmerState();
}

class _ProfileAvatarShimmerState extends State<ProfileAvatarShimmer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: const Stack(
        children: [],
      ),
    );
  }
}

class CircleAvatar extends StatelessWidget {
  CircleAvatar({super.key});

  final GeneralConfig generalConfig = Modular.get<GeneralConfig>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: theme.primaryColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.primaryColor,
          width: 5,
        ),
      ),
    );
  }
}

class EditIconPlaceholder extends StatelessWidget {
  const EditIconPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFF4F4F4),
          border: Border.all(
            color: theme.primaryColor,
            width: 5,
          ),
        ),
        child: Icon(
          Icons.edit_sharp,
          color: theme.primaryColor,
        ),
      ),
    );
  }
}
