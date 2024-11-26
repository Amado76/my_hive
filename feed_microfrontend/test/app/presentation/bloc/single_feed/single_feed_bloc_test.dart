import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:feed_microfrontend/app/data/repository/feed_repository_impl.dart';
import 'package:feed_microfrontend/app/domain/repository/feed_repository_interface.dart';
import 'package:feed_microfrontend/app/domain/usecases/get_single_feed_use_case.dart';
import 'package:feed_microfrontend/app/presentation/bloc/single_feed/single_feed_bloc.dart';
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

  late SingleFeedBloc singleFeedBloc;
  late FeedRepositoryInterface feedRepositoryMock;
  late GetSingleFeedUseCase getFeedUseCase;

  setUp(() {
    feedRepositoryMock = FeedRepositoryMock();
    getFeedUseCase = GetSingleFeedUseCase(feedRepositoryMock);
    singleFeedBloc = SingleFeedBloc(getFeedUseCase);
  });

  group('when [GetSingleFeedDetails] is added', () {
    blocTest<SingleFeedBloc, SingleFeedState>(
      'emits [FeedSingleSuccess] with the entity.',
      build: () => singleFeedBloc,
      setUp: () {
        when(() => feedRepositoryMock.getSingleFeed(formattedSingleFeedMock.id))
            .thenAnswer((_) async => formattedSingleFeedMock);
      },
      act: (bloc) => bloc.add(GetSingleFeedDetails(formattedSingleFeedMock)),
      expect: () => [
        const SingleFeedLoading(),
        SingleFeedSuccess(feedEntity: formattedSingleFeedMock),
      ],
    );

    blocTest<SingleFeedBloc, SingleFeedState>(
      'emits [SingleFeedErrorState] when fails.',
      build: () => singleFeedBloc,
      setUp: () {
        when(() => feedRepositoryMock.getSingleFeed(formattedSingleFeedMock.id))
            .thenThrow(GTecException(message: ''));
      },
      act: (bloc) => bloc.add(GetSingleFeedDetails(formattedSingleFeedMock)),
      expect: () => [
        const SingleFeedLoading(),
        SingleFeedErrorState(feedError: FeedUnknownError())
      ],
    );
  });
}
