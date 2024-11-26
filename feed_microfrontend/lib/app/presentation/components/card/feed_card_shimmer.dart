import 'package:flutter/material.dart';
import 'package:feed_microfrontend/app/presentation/components/card/card_components/feed_card_body_shimmer.dart';
import 'package:feed_microfrontend/app/presentation/components/card/card_components/feed_card_header_shimmer.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class FeedCardShimmer extends StatelessWidget {
  const FeedCardShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SimpleCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          FeedCardHeaderShimmer(),
          FeedCardBodyShimmer(),
        ],
      ),
    );
  }
}
