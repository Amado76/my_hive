import 'package:flutter_test/flutter_test.dart';
import 'package:feed_microfrontend/app/domain/entities/feed_entity.dart';
import 'package:feed_microfrontend/app/domain/repository/feed_repository_interface.dart';
import 'package:feed_microfrontend/app/domain/usecases/get_feed_use_case.dart';
import 'package:mocktail/mocktail.dart';
import '../../../util/response_mocks.dart';

class FeedRepositoryMock extends Mock implements FeedRepositoryInterface {}

void main() {
  late FeedRepositoryMock feedRepositoryMock;
  late GetFeedUseCase getFeedUseCase;

  setUp(() {
    feedRepositoryMock = FeedRepositoryMock();
    getFeedUseCase = GetFeedUseCase(feedRepositoryMock);
    when(() => feedRepositoryMock.getFeed())
        .thenAnswer((_) async => formattedFeedListMock);
  });

  group('[GetFeedUseCase]', () {
    test('should call repository', () async {
      await getFeedUseCase();
      verify(() => feedRepositoryMock.getFeed()).called(1);
    });

    test('should return a list of Entities', () async {
      final result = await getFeedUseCase();
      expect(result, isA<List<FeedEntity>>());
    });
  });
}
