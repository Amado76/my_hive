import 'package:flutter/material.dart';
import 'package:feed_microfrontend/app/presentation/components/card/feed_card_shimmer.dart';

class FeedListShimmer extends StatelessWidget {
  final Function? onRefresh;

  const FeedListShimmer({
    super.key,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(color: Color(0xF4F4F4FF)),
      child: RefreshIndicator(
        onRefresh: () async {
          if (onRefresh != null) onRefresh!();
        },
        color: theme.primaryColor,
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Flexible(
              child: ListView.separated(
                itemCount: 3,
                itemBuilder: (_, index) {
                  return const FeedCardShimmer();
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 26),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.07,
                  vertical: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
