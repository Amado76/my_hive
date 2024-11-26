import 'package:flutter/material.dart';
import 'package:feed_microfrontend/app/domain/entities/feed_entity.dart';
import 'package:feed_microfrontend/app/presentation/components/card/feed_card.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:common_microfrontend/util/design_system/components/indicator/page_center_indicator.dart';

class FeedList extends StatelessWidget {
  final List<FeedEntity> feedEntities;
  final Function? onRefresh;
  final Function? onTapFeedEntity;

  const FeedList({
    super.key,
    required this.feedEntities,
    this.onTapFeedEntity,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final translation = Modular.get<Translation>();
    final theme = Theme.of(context);

    return Stack(
      children: [
        // Indicador de que a lista de feed está vazia
        Visibility(
          visible: feedEntities.isEmpty,
          child: PageCenterIndicator(
            onRefresh: onRefresh,
            indicatorIcon: const Icon(Icons.videocam_off_outlined,
                size: 50, color: Colors.grey),
            indicatorText: Text(
              translation.translate(package: 'feed', key: 'emptyFeed'),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Lista de feed
        Visibility(
          visible: feedEntities.isNotEmpty,
          child: RefreshIndicator(
            onRefresh: () async {
              if (onRefresh != null) onRefresh!();
            },
            color: theme.primaryColor,
            backgroundColor: Colors.black,
            child: Column(
              children: [
                Flexible(
                  child: ListView.separated(
                    itemCount: feedEntities.length,
                    itemBuilder: (_, index) {
                      return FeedCard(
                        feedEntity: feedEntities[index],
                        onTap: onTapFeedEntity,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 26),
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.07,
                      vertical: 24,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
