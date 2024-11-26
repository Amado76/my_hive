import 'package:flutter/foundation.dart' show immutable;
import 'package:feed_microfrontend/app/domain/entities/feed_entity.dart';
import 'package:feed_microfrontend/app/domain/usecases/get_feed_use_case.dart';
import 'package:feed_microfrontend/app/util/feed_error.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

part 'feed_state.dart';
part 'feed_event.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc(
    this.getFeedUseCase,
  ) : super(const FeedLoading()) {
    on<LoadFeed>(_onLoadFeed);
  }

  final GetFeedUseCase getFeedUseCase;

  void _onLoadFeed(LoadFeed event, Emitter<FeedState> emit) async {
    emit(const FeedLoading());
    try {
      final feedEntities = await getFeedUseCase();

      emit(FeedSuccess(feedEntities: feedEntities));
    } on Exception catch (e) {
      emit(FeedErrorState(feedError: FeedError.from(e)));
    }
  }
}
