part of 'feed_bloc.dart';

@immutable
sealed class FeedEvent extends Equatable {
  const FeedEvent();
}

@immutable
class LoadFeed extends FeedEvent {
  const LoadFeed();

  @override
  List<Object?> get props => [];
}
