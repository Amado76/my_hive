import 'package:common_microfrontend/util/theme_and_colors/presentation/widgets/theme_mode_color_extension.dart';
import 'package:flutter/material.dart';

class ProfileSubmitButton extends StatefulWidget {
  const ProfileSubmitButton({
    super.key,
    required this.label,
    required this.onSubmit,
    required this.actionLabel,
  });

  final String label;
  final String actionLabel;
  final Function onSubmit;

  @override
  State<ProfileSubmitButton> createState() => _ProfileSubmitButtonState();
}

class _ProfileSubmitButtonState extends State<ProfileSubmitButton> {
  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final themeMode = Theme.of(context).extension<ThemeModeColorExtension>();
    return ElevatedButton(
      onPressed: () => isSubmitting ? () => {} : widget.onSubmit(),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: isSubmitting
            ? Colors.grey[600]
            : Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontSize: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: isSubmitting
          ? LoadingActionText(widget: widget)
          : Text(
              widget.label.toUpperCase(),
              style: TextStyle(color: themeMode!.textColor),
            ),
    );
  }
}

class LoadingActionText extends StatelessWidget {
  const LoadingActionText({
    super.key,
    required this.widget,
  });

  final ProfileSubmitButton widget;

  @override
  Widget build(BuildContext context) {
    final themeMode = Theme.of(context).extension<ThemeModeColorExtension>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.actionLabel.toUpperCase(),
          style: TextStyle(color: themeMode!.textColor),
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            color: themeMode.textColor,
            strokeWidth: 2,
          ),
        ),
      ],
    );
  }
}
