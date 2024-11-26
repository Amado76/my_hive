part of 'single_feed_bloc.dart';

@immutable
sealed class SingleFeedEvent extends Equatable {
  const SingleFeedEvent();
}

@immutable
class GetSingleFeedDetails extends SingleFeedEvent {
  const GetSingleFeedDetails(
    this.feedEntity,
  );

  final FeedEntity feedEntity;

  @override
  List<Object?> get props => [feedEntity];
}
