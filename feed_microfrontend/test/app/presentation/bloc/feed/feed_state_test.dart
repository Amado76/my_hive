import 'package:flutter_test/flutter_test.dart';
import 'package:feed_microfrontend/app/domain/entities/feed_entity.dart';
import 'package:feed_microfrontend/app/presentation/bloc/feed/feed_bloc.dart';
import 'package:feed_microfrontend/app/util/feed_error.dart';
import 'package:feed_microfrontend/l10n/translation_feed.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

import '../../../../util/response_mocks.dart';

void main() {
  Modular.bindModule(GeneralConfigModular());

  GeneralConfig gc = Modular.get<GeneralConfig>();
  gc.reset();
  gc.business = GeneralBusiness.education;
  gc.language = 'en';

  final translation = Modular.get<Translation>();
  translation.reset(business: GeneralBusiness.education);

  translation.registerTranslations(
    TranslationFeed(),
  );
  group('[FeedLoading]', () {
    test('supports value comparisons', () {
      expect(const FeedLoading(), const FeedLoading());
    });
  });
  group('[FeedSuccess]', () {
    test('supports value comparisons', () {
      expect(
        FeedSuccess(feedEntities: formattedFeedListMock),
        FeedSuccess(feedEntities: formattedFeedListMock),
      );
    });
  });
  group('[FeedErrorState]', () {
    test('supports value comparisons', () {
      expect(
        FeedErrorState(feedError: FeedUnknownError()),
        FeedErrorState(feedError: FeedUnknownError()),
      );
    });
  });

  group('[FeedState]', () {
    test('test getters for success', () {
      final feedSuccess = FeedSuccess(feedEntities: formattedFeedListMock);

      // Cast para FeedState para acessar as extensões
      final state = feedSuccess as FeedState;

      expect(state.feedEntities, isA<List<FeedEntity>>());
    });

    test('test getters for others', () {
      const feedLoadingState = FeedLoading();

      const state = feedLoadingState as FeedState;

      expect(state.feedEntities, isA<List<FeedEntity>>());
      expect(state.feedEntities, isEmpty);
    });
  });
}

class GeneralConfigModular extends Module {
  @override
  List<Module> get imports => [
        CommonModule(),
      ];
}
