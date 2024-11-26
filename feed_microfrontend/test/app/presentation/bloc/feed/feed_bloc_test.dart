import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:feed_microfrontend/app/data/repository/feed_repository_impl.dart';
import 'package:feed_microfrontend/app/domain/repository/feed_repository_interface.dart';
import 'package:feed_microfrontend/app/domain/usecases/get_feed_use_case.dart';
import 'package:feed_microfrontend/app/presentation/bloc/feed/feed_bloc.dart';
import 'package:feed_microfrontend/app/util/feed_error.dart';
import 'package:feed_microfrontend/l10n/translation_feed.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../util/response_mocks.dart';

class FeedRepositoryMock extends Mock implements FeedRepositoryImpl {}

class GeneralConfigModular extends Module {
  @override
  List<Module> get imports => [
        CommonModule(),
      ];
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Modular.bindModule(GeneralConfigModular());

  final GeneralConfig gc = Modular.get<GeneralConfig>();
  gc.reset();
  gc.business = GeneralBusiness.education;
  gc.language = WidgetsBinding.instance.platformDispatcher.locale.languageCode;

  Modular.get<Translation>().registerTranslations(
    TranslationFeed(),
  );

  late FeedBloc feedBloc;
  late FeedRepositoryInterface feedRepositoryMock;
  late GetFeedUseCase getFeedUseCase;

  setUp(() {
    feedRepositoryMock = FeedRepositoryMock();
    getFeedUseCase = GetFeedUseCase(feedRepositoryMock);
    feedBloc = FeedBloc(getFeedUseCase);
  });

  group('when [LoadFeed] is added', () {
    blocTest<FeedBloc, FeedState>(
      'emits [FeedSuccess] with entities.',
      build: () => feedBloc,
      setUp: () {
        when(() => feedRepositoryMock.getFeed())
            .thenAnswer((_) async => formattedFeedListMock);
      },
      act: (bloc) => bloc.add(const LoadFeed()),
      expect: () => [
        const FeedLoading(),
        FeedSuccess(feedEntities: formattedFeedListMock),
      ],
    );

    blocTest<FeedBloc, FeedState>(
      'emits [FeedError] when fail',
      build: () => feedBloc,
      setUp: () {
        when(() => feedRepositoryMock.getFeed())
            .thenThrow(GTecException(message: ''));
      },
      act: (bloc) => bloc.add(const LoadFeed()),
      expect: () =>
          [const FeedLoading(), FeedErrorState(feedError: FeedUnknownError())],
    );
  });
}
