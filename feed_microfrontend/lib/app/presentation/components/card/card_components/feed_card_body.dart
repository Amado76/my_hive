import 'package:flutter/material.dart';

class FeedCardBody extends StatelessWidget {
  const FeedCardBody({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
        child: Column(
          children: [
            FeedCardBodyTitle(title),
            const SizedBox(height: 10),
            FeedCardBodyContent(content),
          ],
        ));
  }
}

class FeedCardBodyTitle extends StatelessWidget {
  const FeedCardBodyTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontSize: 22),
      ),
    );
  }
}

class FeedCardBodyContent extends StatelessWidget {
  const FeedCardBodyContent(this.content, {super.key});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        content,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.grey,
          height: 1.1,
        ),
      ),
    );
  }
}
