import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class FeedCardHeaderShimmer extends StatelessWidget {
  const FeedCardHeaderShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22), topRight: Radius.circular(22)),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 165,
          decoration: BoxDecoration(color: Colors.grey[300]),
        ),
      ),
    );
  }
}
