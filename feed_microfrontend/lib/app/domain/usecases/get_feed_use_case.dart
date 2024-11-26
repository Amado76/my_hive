import 'package:feed_microfrontend/app/domain/entities/feed_entity.dart';
import 'package:feed_microfrontend/app/domain/repository/feed_repository_interface.dart';

class GetFeedUseCase {
  final FeedRepositoryInterface _feedRepository;

  GetFeedUseCase(this._feedRepository);

  Future<List<FeedEntity>> call() async {
    return await _feedRepository.getFeed();
  }
}
