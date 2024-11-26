import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:common_microfrontend/util/theme_and_colors/presentation/widgets/theme_mode_color_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class ClickableLinksText extends StatelessWidget {
  final String text;

  const ClickableLinksText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final themeMode = Theme.of(context).extension<ThemeModeColorExtension>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: themeMode!.textColor,
          ),
          children: _buildTextSpans(text, context),
        ),
      ),
    );
  }

  List<TextSpan> _buildTextSpans(String text, BuildContext context) {
    final List<TextSpan> spans = [];
    final RegExp urlRegex = RegExp(
      r'(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])',
      caseSensitive: false,
    );

    final Iterable<RegExpMatch> matches = urlRegex.allMatches(text);
    int lastMatchEnd = 0;

    for (final match in matches) {
      final int start = match.start;
      final int end = match.end;

      if (start > lastMatchEnd) {
        spans.add(TextSpan(
          text: text.substring(lastMatchEnd, start),
        ));
      }

      final String url = text.substring(start, end);

      spans.add(
        TextSpan(
          text: url,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              // if (await canLaunchUrl(Uri(path: url))) {
              await launchUrl(
                Uri.parse(url),
                mode: LaunchMode.externalApplication,
              );
              // } else {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(
              //       content: Text('Could not launch $url'),
              //     ),
              //   );
              // }
            },
        ),
      );

      lastMatchEnd = end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return spans;
  }
}
