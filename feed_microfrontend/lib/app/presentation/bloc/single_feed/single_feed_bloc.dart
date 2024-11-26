import 'package:flutter/foundation.dart' show immutable;
import 'package:feed_microfrontend/app/domain/entities/feed_entity.dart';
import 'package:feed_microfrontend/app/domain/usecases/get_single_feed_use_case.dart';
import 'package:feed_microfrontend/app/util/feed_error.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

part 'single_feed_state.dart';
part 'single_feed_event.dart';

class SingleFeedBloc extends Bloc<SingleFeedEvent, SingleFeedState> {
  SingleFeedBloc(
    this.getSingleFeedUseCase,
  ) : super(const SingleFeedLoading()) {
    on<GetSingleFeedDetails>(_onGetSingleFeedDetails);
  }

  final GetSingleFeedUseCase getSingleFeedUseCase;

  void _onGetSingleFeedDetails(
      GetSingleFeedDetails event, Emitter<SingleFeedState> emit) async {
    emit(const SingleFeedLoading());
    try {
      final feedEntity = await getSingleFeedUseCase(event.feedEntity);
      emit(SingleFeedSuccess(feedEntity: feedEntity));
    } on Exception catch (e) {
      emit(SingleFeedErrorState(feedError: FeedError.from(e)));
    }
  }
}
