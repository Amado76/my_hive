import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class FeedEntity {
  final int id;
  final String title;
  final String text;
  final String date;
  final String image;
  final String? linkType;
  final String? linkUrl;

  FeedEntity({
    required this.id,
    required this.title,
    required this.text,
    required this.date,
    required this.image,
    this.linkType,
    this.linkUrl,
  });

  factory FeedEntity.fromJson(Map<String, dynamic> json) {
    return FeedEntity(
      id: json['id'],
      title: json['title'],
      text: json['text'],
      date: json['date'],
      image: json['image'],
      linkType: json['link_type'],
      linkUrl: json['link'],
    );
  }

  String get sanitizedText =>
      text.replaceAll('<br>', '\n\n').replaceAll('&nbsp;', '');

  String get parsedText {
    var htmlParser = parse(sanitizedText);
    return htmlParser.body!.text;
  }

  bool get hasArchiveMedia => linkType == 'archive';

  bool get hasVideoMedia => linkType == 'video';

  bool get hasExternalLink => linkUrl != null && linkUrl!.isNotEmpty;
}

extension GetLinkIcon on FeedEntity {
  IconData get linkIcon {
    if (hasArchiveMedia) {
      return Icons.file_download_outlined;
    }
    if (hasVideoMedia) {
      return Icons.play_circle_outline_rounded;
    }

    return Icons.link_outlined;
  }
}
