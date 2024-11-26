import 'package:flutter/material.dart';
import 'package:common_microfrontend/util/theme_and_colors/presentation/widgets/theme_mode_color_extension.dart';

class SimpleCard extends StatelessWidget {
  const SimpleCard({super.key, required this.child, required this.padding});

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final themeMode = Theme.of(context).extension<ThemeModeColorExtension>();
    return Container(
      decoration: BoxDecoration(
        color: themeMode!.cardColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(1),
            offset: const Offset(0, 0),
            blurRadius: 8,
            spreadRadius: -6,
          ),
        ],
      ),
      padding: padding,
      child: child,
    );
  }
}
