import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:feed_microfrontend/app/data/repository/feed_repository_impl.dart';
import 'package:feed_microfrontend/app/domain/repository/feed_repository_interface.dart';
import 'package:feed_microfrontend/app/domain/usecases/get_feed_use_case.dart';
import 'package:feed_microfrontend/app/domain/usecases/get_single_feed_use_case.dart';
import 'package:feed_microfrontend/app/presentation/bloc/feed/feed_bloc.dart';
import 'package:feed_microfrontend/app/presentation/bloc/single_feed/single_feed_bloc.dart';
import 'package:feed_microfrontend/app/presentation/pages/feed_page.dart';
import 'package:feed_microfrontend/app/presentation/pages/single_feed_page.dart';
import 'package:feed_microfrontend/app/util/feed_urls.dart';
import 'package:feed_microfrontend/l10n/translation_feed.dart';

class FeedModule extends Module {
  BindConfig<T> blocConfig<T extends Bloc>() {
    return BindConfig(
      notifier: (bloc) => bloc.stream,
      onDispose: (bloc) => bloc.close(),
    );
  }

  @override
  void binds(i) {
    Modular.get<Translation>().registerTranslations(
      TranslationFeed(),
    );

    UrlInjector.instance.registerUrl(FeedUrls());

    // Repository
    i.addSingleton<FeedRepositoryInterface>(() => FeedRepositoryImpl(
        httpClient: i<HttpClientInterface>(),
        urlInjector: UrlInjector.instance));
    // UseCases
    i.addSingleton<GetFeedUseCase>(GetFeedUseCase.new);
    i.addSingleton<GetSingleFeedUseCase>(GetSingleFeedUseCase.new);
    // Bloc
    i.addSingleton<FeedBloc>(FeedBloc.new, config: blocConfig());
    i.addSingleton<SingleFeedBloc>(SingleFeedBloc.new, config: blocConfig());
  }

  @override
  void routes(r) {
    final NavigationInjector navigator = Modular.get<NavigationInjector>();
    navigator.setPaths(package: "tips", pathList: {
      "root": "/",
      "single-feed": "/single-feed",
    });

    r.child(
      navigator.getPath(package: "tips", pathKey: "root"),
      child: (_) => const FeedPage(),
    );
    r.child(
      navigator.getPath(package: "tips", pathKey: "single-feed"),
      child: (_) => const SingleFeedPage(),
      transition: TransitionType.rightToLeft,
    );
  }
}
