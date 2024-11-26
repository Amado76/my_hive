import 'package:feed_microfrontend/app/domain/entities/feed_entity.dart';

abstract class FeedRepositoryInterface {
  Future<List<FeedEntity>> getFeed();
  Future<FeedEntity> getSingleFeed(int id);
}
