import 'package:flutter_test/flutter_test.dart';
import 'package:feed_microfrontend/app/domain/entities/feed_entity.dart';
import 'package:feed_microfrontend/app/presentation/bloc/single_feed/single_feed_bloc.dart';
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
  group('[SingleFeedLoading]', () {
    test('supports value comparisons', () {
      expect(const SingleFeedLoading(), const SingleFeedLoading());
    });
  });
  group('[SingleFeedSuccess]', () {
    test('supports value comparisons', () {
      expect(
        SingleFeedSuccess(feedEntity: formattedSingleFeedMock),
        SingleFeedSuccess(feedEntity: formattedSingleFeedMock),
      );
    });
  });
  group('[FeedErrorState]', () {
    test('supports value comparisons', () {
      expect(
        SingleFeedErrorState(feedError: FeedUnknownError()),
        SingleFeedErrorState(feedError: FeedUnknownError()),
      );
    });
  });

  group('[FeedState]', () {
    test('test getters for success', () {
      final feedSuccess =
          SingleFeedSuccess(feedEntity: formattedSingleFeedMock);

      // Cast para FeedState para acessar as extensões
      final state = feedSuccess as SingleFeedState;

      expect(state.feedEntity, isA<FeedEntity>());
    });

    test('test getters for others', () {
      const feedLoadingState = SingleFeedLoading();

      const state = feedLoadingState as SingleFeedState;

      expect(state.feedEntity, isNull);
    });
  });
}

class GeneralConfigModular extends Module {
  @override
  List<Module> get imports => [
        CommonModule(),
      ];
}
