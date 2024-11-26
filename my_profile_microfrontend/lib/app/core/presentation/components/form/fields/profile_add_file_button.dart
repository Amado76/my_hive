import 'package:common_microfrontend/util/theme_and_colors/presentation/widgets/theme_mode_color_extension.dart';
import 'package:flutter/material.dart';

class ProfileAddFileButton extends StatefulWidget {
  const ProfileAddFileButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  final VoidCallback onPressed;
  final String label;

  @override
  State<ProfileAddFileButton> createState() => _ProfileAddFileButtonState();
}

class _ProfileAddFileButtonState extends State<ProfileAddFileButton> {
  @override
  Widget build(BuildContext context) {
    final themeMode = Theme.of(context).extension<ThemeModeColorExtension>();
    return ElevatedButton(
      onPressed: () => widget.onPressed(),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: themeMode!.backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontSize: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.5,
          ),
        ),
      ),
      child: Text(
        widget.label.toUpperCase(),
        style: TextStyle(color: themeMode.textColor),
      ),
    );
  }
}
