import 'package:flutter/material.dart';

Future<T?> generateAlertDialog<T>(
    {required BuildContext context,
    required String title,
    required Widget content,
    required Color backgroundColor,
    required Color titleTextColor,
    Widget? imageTitle,
    Widget? actions,
    barrierDismissible = false}) {
  return showAdaptiveDialog<T>(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: backgroundColor,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageTitle ?? const SizedBox(),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: titleTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          content: content,
          actions: actions == null ? null : [actions],
        );
      });
}
