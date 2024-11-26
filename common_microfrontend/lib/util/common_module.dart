import 'package:common_microfrontend/modules/user/conf/user_urls.dart';
import 'package:common_microfrontend/modules/user/data/repositories/auth_user_repository_impl.dart';
import 'package:common_microfrontend/modules/user/data/repositories/group_repository_impl.dart';
import 'package:common_microfrontend/modules/user/data/repositories/module_auth_repository_impl.dart';
import 'package:common_microfrontend/modules/user/data/repositories/user_repository_impl.dart';
import 'package:common_microfrontend/modules/user/domain/repositories/auth_user_repository_interface.dart';
import 'package:common_microfrontend/modules/user/domain/repositories/group_repository_interface.dart';
import 'package:common_microfrontend/modules/user/domain/repositories/module_auth_repository_interface.dart';
import 'package:common_microfrontend/modules/user/domain/repositories/user_repository_interface.dart';
import 'package:common_microfrontend/modules/user/domain/usecases/delete_user_token_use_case.dart';
import 'package:common_microfrontend/modules/user/domain/usecases/generate_user_entity_use_case.dart';
import 'package:common_microfrontend/modules/user/domain/usecases/get_current_profile_use_case.dart';
import 'package:common_microfrontend/modules/user/domain/usecases/save_user_token_use_case.dart';
import 'package:common_microfrontend/util/design_system/components/animated_drawer/data/drawer_item_repository_impl.dart';
import 'package:common_microfrontend/util/design_system/components/animated_drawer/domain/interfaces/drawer_item_repository_interface.dart';
import 'package:common_microfrontend/util/design_system/components/animated_drawer/domain/use_case/get_drawer_filtered_use_case.dart';
import 'package:common_microfrontend/util/design_system/components/animated_drawer/presentation/drawer_data.dart';
import 'package:common_microfrontend/util/general_config/general_config.dart';
import 'package:common_microfrontend/util/http_client/http_client_adapter.dart';
import 'package:common_microfrontend/util/http_client/interceptors/auth_token_interceptor.dart';
import 'package:common_microfrontend/util/http_client/interceptors/dio_exception_interceptor.dart';
import 'package:common_microfrontend/util/http_client/interceptors/status_error_interceptor.dart';
import 'package:common_microfrontend/util/navigation_injector/navigation_injector.dart';
import 'package:common_microfrontend/util/secure_local_storage/secure_local_storage_adapter.dart';
import 'package:common_microfrontend/util/theme_and_colors/conf/theme_urls.dart';
import 'package:common_microfrontend/util/theme_and_colors/data/theme_repository_imp.dart';
import 'package:common_microfrontend/util/theme_and_colors/domain/interfaces/theme_repository_interface.dart';
import 'package:common_microfrontend/util/theme_and_colors/domain/usecase/change_theme_usecase.dart';
import 'package:common_microfrontend/util/theme_and_colors/presentation/bloc/theme_and_colors_bloc.dart';
import 'package:common_microfrontend/util/translation/domain/entity/translation.dart';
import 'package:common_microfrontend/util/translation/presentation/bloc/translation_bloc.dart';
import 'package:common_microfrontend/util/url_injector/url_injector.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:modular_core/modular_core.dart';

class CommonModule extends Module {
  @override
  void exportedBinds(Injector i) {
    UrlInjector.instance.registerUrl(ThemeUrls());
    UrlInjector.instance.registerUrl(UserUrls());

    //HttpClient
    i.addSingleton<HttpClientInterface>(
      () => DioAdapter(
        dio: Dio(),
        interceptors: [
          DioExceptionInterceptor(),
          StatusErrorInterceptor(),
          AuthTokenInterceptor()
        ],
      ),
    );
    //HttpCLient2
    i.add<HttpClientDownloadInterface>(() => DioDownloadAdappter(
          dio: Dio(),
        ));

    //SecureLocalStorage
    i.addSingleton<SecureLocalStorageInterface>(SecureLocalStorageAdapter.new);
    i.addSingleton<FlutterSecureStorage>(FlutterSecureStorage.new);
    //NavigationInjector
    i.addSingleton<NavigationInjector>(NavigationInjector.new);
    //AuthUserRepository
    i.addSingleton<AuthUserRepositoryInterface>(AuthUserRepositoryImpl.new);
    i.addSingleton<UrlInjector>(() => UrlInjector.instance);

    i.addSingleton<ThemeAndColorsBloc>(ThemeAndColorsBloc.new);
    //Singleton do Bloc do Translate
    i.addSingleton<TranslationBloc>(TranslationBloc.new);
    //GeneralConfig deve ter suas propriedades setadas pelos setters
    i.addSingleton<GeneralConfig>(GeneralConfig.new);

    i.addSingleton<Translation>(Translation.new);

    i.addSingleton<SaveUserTokenUseCase>(SaveUserTokenUseCase.new);

    i.addSingleton<ThemeRepositoryInterface>(ThemeRepositoryImp.new);
    i.addSingleton<ChangeThemeUsecase>(ChangeThemeUsecase.new);

    //Injeções para a geração da Entity User
    i.addSingleton<ModuleAuthRepositoryInterface>(ModuleAuthRepositoryImpl.new);
    i.addSingleton<GroupRepositoryInterface>(GroupRepositoryImpl.new);
    i.addSingleton<UserRepositoryInterface>(UserRepositoryImpl.new);
    i.addSingleton<GenerateUserEntityUseCase>(GenerateUserEntityUseCase.new);
    //Design_system
    i.addSingleton<DrawerItemRepositoryInterface>(
      () => DrawerItemRepositoryImpl(
        gc: i<GeneralConfig>(),
        translation: i<Translation>(),
      ),
    );
    i.addSingleton<GetDrawerFilteredUseCase>(() => GetDrawerFilteredUseCase(
          drawerRepository: i<DrawerItemRepositoryInterface>(),
          generalConfig: i<GeneralConfig>(),
          navigator: i<NavigationInjector>(),
          translation: i<Translation>(),
        ));
    i.addSingleton<GetCurrentProfileUseCase>(
      () => GetCurrentProfileUseCase(
        i<GeneralConfig>(),
      ),
    );
    i.addSingleton<DrawerData>(
      () => DrawerData(
        translation: i<Translation>(),
        navigator: i<NavigationInjector>(),
        logoutUseCase: i<DeleteUserTokenUseCase>(),
        getCurrentProfile: i<GetCurrentProfileUseCase>(),
        getDrawerFilteredUseCase: i<GetDrawerFilteredUseCase>(),
      ),
    );
    i.addLazySingleton<DeleteUserTokenUseCase>(
      () => DeleteUserTokenUseCase(
        i<AuthUserRepositoryInterface>(),
      ),
    );
  }
}
