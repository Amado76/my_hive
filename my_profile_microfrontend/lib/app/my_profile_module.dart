import 'package:my_profile_microfrontend/app/core/data/repository/address_repository_impl.dart';
import 'package:my_profile_microfrontend/app/core/data/repository/my_profile_repository_impl.dart';
import 'package:my_profile_microfrontend/app/core/domain/repository/address_repository_interface.dart';
import 'package:my_profile_microfrontend/app/core/domain/repository/my_profile_repository_interface.dart';
import 'package:my_profile_microfrontend/app/core/domain/usecases/get_profile_use_case.dart';
import 'package:my_profile_microfrontend/app/core/domain/usecases/update_profile_use_case.dart';
import 'package:my_profile_microfrontend/app/student/presentation/bloc/student_profile_bloc.dart';
import 'package:my_profile_microfrontend/app/student/presentation/pages/student_profile_page.dart';
import 'package:my_profile_microfrontend/app/util/my_profile_urls.dart';
import 'package:my_profile_microfrontend/l10n/translation_my_profile.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class MyProfileModule extends Module {
  final String? isoCode;

  MyProfileModule({required this.isoCode});
  BindConfig<T> blocConfig<T extends Bloc>() {
    return BindConfig(
      notifier: (bloc) => bloc.stream,
      onDispose: (bloc) => bloc.close(),
    );
  }

  @override
  void binds(i) {
    Modular.get<Translation>().registerTranslations(
      TranslationMyProfile(),
    );

    UrlInjector.instance.registerUrl(MyProfileUrls());

    // Repository
    i.addSingleton<MyProfileRepositoryInterface>(
      () => MyProfileRepositoryImpl(
        httpClient: i<HttpClientInterface>(),
        urlInjector: UrlInjector.instance,
      ),
    );
    i.addSingleton<AddressRepositoryInterface>(
      () => AddressRepositoryImpl(
        httpClient: i<HttpClientInterface>(),
      ),
    );
    // UseCases
    i.addSingleton<GetProfileUseCase>(GetProfileUseCase.new);
    i.addSingleton<UpdateProfileUseCase>(UpdateProfileUseCase.new);
    // Bloc
    i.addSingleton<StudentProfileBloc>(
      () => StudentProfileBloc(
        i<GetProfileUseCase>(),
        i<UpdateProfileUseCase>(),
        i<DeleteUserTokenUseCase>(),
      ),
      config: blocConfig(),
    );
  }

  @override
  void routes(r) {
    final NavigationInjector navigator = Modular.get<NavigationInjector>();
    navigator.setPaths(package: "my_profile", pathList: {
      "teacherRoot": "/teacher",
      "studentRoot": "/",
    });

    r.child(
      navigator.getPath(package: "my_profile", pathKey: "studentRoot"),
      child: (_) => StudentProfilePage(
        isoCode: isoCode,
      ),
    );
  }
}
