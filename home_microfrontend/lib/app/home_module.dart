import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:home_microfrontend/app/core/util/urls/home_urls.dart';
import 'package:home_microfrontend/app/home/data/repository/home_repository_impl.dart';
import 'package:home_microfrontend/app/home/domain/repository/home_repository_interface.dart';
import 'package:home_microfrontend/app/home/domain/use_case/get_home_data_use_case.dart';
import 'package:home_microfrontend/app/home/domain/use_case/has_communication_notifications_use_case.dart';
import 'package:home_microfrontend/app/home/presentation/bloc/home_bloc.dart';
import 'package:home_microfrontend/app/home/presentation/page/home_page.dart';
import 'package:home_microfrontend/app/terms/data/repository/terms_repository_impl.dart';
import 'package:home_microfrontend/app/terms/domain/repository/terms_repository_interface.dart';
import 'package:home_microfrontend/app/terms/domain/usecase/accept_terms_use_case.dart';
import 'package:home_microfrontend/app/terms/domain/usecase/get_terms_use_case.dart';
import 'package:home_microfrontend/app/terms/domain/usecase/user_accepted_latest_terms_use_case.dart';
import 'package:home_microfrontend/l10n/translation_home.dart';

class HomeModule extends Module {
  HomeModule();
  BindConfig<T> blocConfig<T extends Bloc>() {
    return BindConfig(
      notifier: (bloc) => bloc.stream,
      onDispose: (bloc) => bloc.close(),
    );
  }

  @override
  void binds(i) {
    Modular.get<Translation>().registerTranslations(
      TranslationHome(),
    );

    UrlInjector.instance.registerUrl(HomeUrls());
    //HomeBloc
    i.addLazySingleton<HomeBloc>(
        () => HomeBloc(
              getHomeDataUseCase: i<GetHomeDataUseCase>(),
              hasCommunicationNotificationsUseCase:
                  i<HasCommunicationNotificationsUseCase>(),
              userAcceptedLastTermsUseCase: i<UserAcceptedLastTermsUseCase>(),
              acceptTermsUseCase: i<AcceptTermsUseCase>(),
              getTermsUseCase: i<GetTermsUseCase>(),
              getCurrentProfileUseCase: i<GetCurrentProfileUseCase>(),
            ),
        config: blocConfig());

    //HomeRepository
    i.addLazySingleton<HomeRepositoryInterface>(() => HomeRepositoryImpl(
        httpClient: i<HttpClientInterface>(),
        urlInjector: UrlInjector.instance));
    i.addLazySingleton<HasCommunicationNotificationsUseCase>(
        HasCommunicationNotificationsUseCase.new);
    i.addLazySingleton<GetHomeDataUseCase>(GetHomeDataUseCase.new);

    //TermsRepository
    i.addLazySingleton<TermsRepositoryInterface>(() => TermsRepositoryImpl(
        httpClient: i<HttpClientInterface>(),
        urlInjector: UrlInjector.instance));
    i.addLazySingleton<AcceptTermsUseCase>(AcceptTermsUseCase.new);
    i.addLazySingleton<GetTermsUseCase>(GetTermsUseCase.new);
    i.addLazySingleton<UserAcceptedLastTermsUseCase>(
        UserAcceptedLastTermsUseCase.new);
  }

  @override
  void routes(r) {
    final NavigationInjector navigator = Modular.get<NavigationInjector>();
    navigator.setPaths(package: "home", pathList: {
      "root": "/",
    });
    r.child(navigator.getPath(package: "home", pathKey: "root"),
        child: (_) => const HomePage());
  }
}
