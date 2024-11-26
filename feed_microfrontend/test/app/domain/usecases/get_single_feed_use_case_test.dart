import 'package:flutter_test/flutter_test.dart';
import 'package:feed_microfrontend/app/domain/entities/feed_entity.dart';
import 'package:feed_microfrontend/app/domain/repository/feed_repository_interface.dart';
import 'package:feed_microfrontend/app/domain/usecases/get_single_feed_use_case.dart';
import 'package:mocktail/mocktail.dart';
import '../../../util/response_mocks.dart';

class FeedRepositoryMock extends Mock implements FeedRepositoryInterface {}

void main() {
  late FeedRepositoryMock feedRepositoryMock;
  late GetSingleFeedUseCase getSingleFeedUseCase;

  setUp(() {
    feedRepositoryMock = FeedRepositoryMock();
    getSingleFeedUseCase = GetSingleFeedUseCase(feedRepositoryMock);
    when(() => feedRepositoryMock.getSingleFeed(formattedSingleFeedMock.id))
        .thenAnswer((_) async => formattedSingleFeedMock);
  });

  group('[GetSingleFeedUseCase]', () {
    test('should call the repository', () async {
      await getSingleFeedUseCase(formattedSingleFeedMock);

      verify(() => feedRepositoryMock.getSingleFeed(formattedSingleFeedMock.id))
          .called(1);
    });

    test('should return a single FeedEntity', () async {
      final result = await getSingleFeedUseCase(formattedSingleFeedMock);

      expect(result, isA<FeedEntity>());
    });
  });
}
