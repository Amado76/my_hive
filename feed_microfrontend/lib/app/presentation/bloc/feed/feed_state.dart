part of 'feed_bloc.dart';

@immutable
sealed class FeedState extends Equatable {
  const FeedState();
}

@immutable
class FeedLoading extends FeedState {
  const FeedLoading();
  @override
  List<Object?> get props => [];
}

@immutable
class FeedErrorState extends FeedState {
  final FeedError feedError;

  const FeedErrorState({required this.feedError});

  @override
  List<Object?> get props => [feedError];
}

@immutable
class FeedSuccess extends FeedState {
  final List<FeedEntity> feedEntities;

  const FeedSuccess({required this.feedEntities});

  @override
  List<Object?> get props => [feedEntities];
}

extension GetFeedEntities on FeedState {
  List<FeedEntity> get feedEntities {
    final state = this;
    if (state is FeedSuccess) {
      return state.feedEntities;
    }
    return [];
  }
}
