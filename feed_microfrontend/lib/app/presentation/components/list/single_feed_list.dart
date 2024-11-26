// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:feed_microfrontend/app/domain/entities/feed_entity.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:common_microfrontend/util/theme_and_colors/presentation/widgets/theme_mode_color_extension.dart';

// ignore: must_be_immutable
class SingleFeedList extends StatelessWidget {
  const SingleFeedList({
    super.key,
    required this.feedEntity,
  });

  final FeedEntity feedEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleFeedListImage(feedEntity: feedEntity),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            children: [
              SingleFeedListTitle(title: feedEntity.title),
              const SizedBox(height: 8),
              SingleFeedListDate(date: feedEntity.date),
              const SizedBox(height: 12),
              SingleFeedListTextContent(content: feedEntity.sanitizedText),
            ],
          ),
        ),
      ],
    );
  }
}

class SingleFeedListTextContent extends StatelessWidget {
  const SingleFeedListTextContent({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      content,
      textStyle: const TextStyle(
        fontSize: 15,
      ),
    );
  }
}

class SingleFeedListDate extends StatelessWidget {
  const SingleFeedListDate({
    super.key,
    required this.date,
  });

  final String date;

  @override
  Widget build(BuildContext context) {
    final themeMode = Theme.of(context).extension<ThemeModeColorExtension>();
    return Row(
      children: [
        Icon(Icons.calendar_month, size: 16, color: themeMode!.textColor),
        const SizedBox(width: 5),
        Text(
          date,
          style: TextStyle(fontSize: 16, color: themeMode.textColor),
        ),
      ],
    );
  }
}

class SingleFeedListTitle extends StatelessWidget {
  const SingleFeedListTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final themeMode = Theme.of(context).extension<ThemeModeColorExtension>();
    return Text(
      title,
      style: TextStyle(
        color: themeMode!.textColor,
        fontSize: 22,
      ),
    );
  }
}

class SingleFeedListImage extends StatelessWidget {
  const SingleFeedListImage({
    super.key,
    required this.feedEntity,
  });

  final FeedEntity feedEntity;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          height: size.height * 0.25,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(feedEntity.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Visibility(
          visible: feedEntity.hasExternalLink,
          child: Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(
                  feedEntity.linkIcon,
                  size: 64.0,
                ),
                onPressed: () async {
                  final url = Uri.parse(feedEntity.linkUrl!);
                  await launchUrl(url);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showLaunchUrlErrorDialog(BuildContext context) {
    final Translation translation = Modular.get<Translation>();

    showDefaultDialog(
        context: context,
        title:
            translation.translate(package: "feed", key: "launchUrlErrorTitle"),
        contentText:
            translation.translate(package: "feed", key: "launchUrlErrorText"),
        customAction: Column(
          children: [
            const Divider(
              color: Colors.grey,
              height: 1,
            ),
            Center(
              child: TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: Text(
                  translation.translate(
                      package: "feed", key: "launchUrlErrorButton"),
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ],
        ));
  }
}
