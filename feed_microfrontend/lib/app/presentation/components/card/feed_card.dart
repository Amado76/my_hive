import 'package:flutter/material.dart';
import 'package:feed_microfrontend/app/domain/entities/feed_entity.dart';
import 'package:feed_microfrontend/app/presentation/components/card/card_components/feed_card_body.dart';
import 'package:feed_microfrontend/app/presentation/components/card/card_components/feed_card_header.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class FeedCard extends StatelessWidget {
  final FeedEntity feedEntity;
  final Function? onTap;

  const FeedCard({
    super.key,
    required this.feedEntity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              if (onTap != null) {onTap!(feedEntity)}
            },
        child: SimpleCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              FeedCardHeader(image: feedEntity.image, date: feedEntity.date),
              FeedCardBody(
                  title: feedEntity.title, content: feedEntity.parsedText),
            ],
          ),
        ));
  }
}
