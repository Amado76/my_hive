import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:feed_microfrontend/app/domain/entities/feed_entity.dart';
import 'package:mocktail/mocktail.dart';

import '../../../util/response_mocks.dart';

class FeedEntityMock extends Mock implements FeedEntity {}

void main() {
  final archiveFeedEntity = FeedEntity.fromJson(
      rawSingleFeedWithArchiveJsonMock['data'] as Map<String, dynamic>);
  final videoFeedEntity = FeedEntity.fromJson(
      rawSingleFeedWithVideoJsonMock['data'] as Map<String, dynamic>);

  group('FeedEntity', () {
    test('sanitizedText replaces <br> with new lines', () {
      expect(archiveFeedEntity.sanitizedText, '<p>Hello\n\nWorld</p>');
    });

    test('parsedText removes HTML tags', () {
      expect(archiveFeedEntity.parsedText, 'Hello\n\nWorld');
    });

    test('hasArchiveMedia returns true if linkType is "archive"', () {
      expect(archiveFeedEntity.hasArchiveMedia, true);
    });

    test('hasVideoMedia returns true if linkType is "video"', () {
      expect(videoFeedEntity.hasVideoMedia, true);
    });

    test('hasExternalLink returns true if linkUrl is not null and not empty',
        () {
      expect(videoFeedEntity.hasExternalLink, true);
    });
  });

  group('GetLinkIcon', () {
    test('linkIcon returns correct icon based on linkType', () {
      expect(archiveFeedEntity.linkIcon, Icons.file_download_outlined);
      expect(videoFeedEntity.linkIcon, Icons.play_circle_outline_rounded);
    });
  });
}
