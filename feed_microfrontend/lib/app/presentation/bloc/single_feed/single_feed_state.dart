part of 'single_feed_bloc.dart';

@immutable
sealed class SingleFeedState extends Equatable {
  const SingleFeedState();
}

@immutable
class SingleFeedLoading extends SingleFeedState {
  const SingleFeedLoading();
  @override
  List<Object?> get props => [];
}

@immutable
class SingleFeedErrorState extends SingleFeedState {
  final FeedError feedError;

  const SingleFeedErrorState({required this.feedError});

  @override
  List<Object?> get props => [feedError];
}

@immutable
class SingleFeedSuccess extends SingleFeedState {
  final FeedEntity feedEntity;

  const SingleFeedSuccess({required this.feedEntity});

  @override
  List<Object?> get props => [feedEntity];
}

extension GetSingleFeedEntity on SingleFeedState {
  FeedEntity? get feedEntity {
    final state = this;
    if (state is SingleFeedSuccess) {
      return state.feedEntity;
    }
    return null;
  }
}
