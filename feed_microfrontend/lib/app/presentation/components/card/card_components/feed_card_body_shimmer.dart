import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class FeedCardBodyShimmer extends StatelessWidget {
  const FeedCardBodyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
      child: const Column(
        children: [
          FeedCardBodyTitleShimmer(),
          SizedBox(height: 18),
          FeedCardBodyContentShimmer(),
        ],
      ),
    );
  }
}

class FeedCardBodyTitleShimmer extends StatelessWidget {
  const FeedCardBodyTitleShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[300]!),
          height: 15,
          width: size.width * 0.3,
        ),
      ),
    );
  }
}

class FeedCardBodyContentShimmer extends StatelessWidget {
  const FeedCardBodyContentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextShimmer(),
        SizedBox(height: 8),
        TextShimmer(),
        SizedBox(height: 8),
        TextShimmer(width: 0.55),
      ],
    );
  }
}

class TextShimmer extends StatelessWidget {
  const TextShimmer({super.key, this.width = 1.0});

  final double width;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[300]!),
        height: 10,
        width: size.width * width,
      ),
    );
  }
}
