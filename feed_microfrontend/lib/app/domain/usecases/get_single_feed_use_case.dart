import 'package:feed_microfrontend/app/domain/entities/feed_entity.dart';
import 'package:feed_microfrontend/app/domain/repository/feed_repository_interface.dart';

class GetSingleFeedUseCase {
  final FeedRepositoryInterface _feedRepository;

  GetSingleFeedUseCase(this._feedRepository);

  Future<FeedEntity> call(FeedEntity feedEntity) async {
    return await _feedRepository.getSingleFeed(feedEntity.id);
  }
}
