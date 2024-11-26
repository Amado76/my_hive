import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class FeedCardHeader extends StatelessWidget {
  const FeedCardHeader({super.key, required this.image, this.date});

  final String image;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(22),
        topRight: Radius.circular(22),
      ),
      child: Stack(
        children: [
          FeedCardHeaderImage(image: image),
          FeedCardHeaderDate(date: date),
        ],
      ),
    );
  }
}

class FeedCardHeaderImage extends StatelessWidget {
  const FeedCardHeaderImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 165,
      width: double.infinity,
      child: Stack(
        children: [
          const FeedCardHeaderImagePlaceholder(),
          Positioned.fill(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.transparent,
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const <double>[0.25, 0.6, 0.8, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcOver,
              child: Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const FeedCardHeaderImagePlaceholder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeedCardHeaderImagePlaceholder extends StatelessWidget {
  const FeedCardHeaderImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 165,
        width: double.infinity,
        color: Colors.grey[200],
        child: Center(
          child: CircularProgressIndicator(
            color: theme.primaryColor,
          ),
        ),
      ),
    );
  }
}

class FeedCardHeaderDate extends StatelessWidget {
  const FeedCardHeaderDate({
    super.key,
    required this.date,
  });

  final String? date;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 10,
      child: date != null
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_month, color: Colors.white, size: 17),
                const SizedBox(width: 5),
                Text(
                  date ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 17),
                ),
              ],
            )
          : const SizedBox(),
    );
  }
}
