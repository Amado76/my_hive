import 'package:auth_microfrontend/app/core/data/dto/auth_config_dto.dart';
import 'package:auth_microfrontend/app/core/data/repository/auth_repository_impl.dart';
import 'package:auth_microfrontend/app/core/domain/repository/auth_repository_interface.dart';
import 'package:auth_microfrontend/app/core/domain/use_case/login_with_phone_number_use_case.dart';
import 'package:auth_microfrontend/app/core/domain/use_case/register_use_case.dart';
import 'package:auth_microfrontend/app/core/domain/use_case/reset_password_use_case.dart';
import 'package:auth_microfrontend/app/login/presentation/bloc/login_bloc.dart';
import 'package:auth_microfrontend/app/login/presentation/page/login_page.dart';
import 'package:auth_microfrontend/app/phone_validation/data/repository/phone_validation_repository_impl.dart';
import 'package:auth_microfrontend/app/phone_validation/domain/repository/phone_validation_repository.dart';
import 'package:auth_microfrontend/app/core/domain/use_case/send_verification_code_to_phone_use_case.dart';
import 'package:auth_microfrontend/app/phone_validation/domain/use_case/verify_phone_with_code_use_case.dart';
import 'package:auth_microfrontend/app/phone_validation/presentation/bloc/phone_validation_bloc.dart';
import 'package:auth_microfrontend/app/core/util/url/authentication_urls.dart';
import 'package:auth_microfrontend/app/phone_validation/presentation/page/phone_validation_page.dart';
import 'package:auth_microfrontend/app/send_validation_sms/data/repository/send_validation_sms_repository_impl.dart';
import 'package:auth_microfrontend/app/send_validation_sms/domain/send_validation_sms_repository.dart';
import 'package:auth_microfrontend/app/send_validation_sms/presentation/bloc/send_validation_sms_bloc.dart';
import 'package:auth_microfrontend/app/send_validation_sms/presentation/page/send_validation_sms_page.dart';
import 'package:auth_microfrontend/app/recover_password/presentation/bloc/recover_password_bloc.dart';
import 'package:auth_microfrontend/app/recover_password/presentation/page/recover_password_page.dart';
import 'package:auth_microfrontend/app/register/presentation/bloc/register_bloc.dart';
import 'package:auth_microfrontend/app/register/presentation/page/register_page.dart';
import 'package:auth_microfrontend/l10n/translation_auth.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class AuthenticationModule extends Module {
  final AuthConfigDto authConfigDto;
  final String homeUrl;

  AuthenticationModule({
    required this.authConfigDto,
    required this.homeUrl,
  });

  BindConfig<T> blocConfig<T extends Bloc>() {
    return BindConfig(
      notifier: (bloc) => bloc.stream,
      onDispose: (bloc) => bloc.close(),
    );
  }

  @override
  void binds(i) {
    Modular.get<Translation>().registerTranslations(
      TranslationAuth(),
    );

    UrlInjector.instance.registerUrl(AuthenticationUrls());

    //AuthRepository
    i.addSingleton<AuthRepositoryInterface>(() => AuthRepositoryImpl(
        httpClient: i<HttpClientInterface>(),
        urlInjector: UrlInjector.instance));
    //Login
    i.addSingleton<LoginBloc>(
      () => LoginBloc(
        loginWithPhoneNumberUseCase: i<LoginWithPhoneNumberUseCase>(),
        saveUserTokenUseCase: i<SaveUserTokenUseCase>(),
        gc: i<GeneralConfig>(),
      ),
      config: blocConfig(),
    );
    i.addSingleton<SaveUserTokenUseCase>(
        () => SaveUserTokenUseCase(i<AuthUserRepositoryInterface>()));
    i.addSingleton<LoginWithPhoneNumberUseCase>(
        LoginWithPhoneNumberUseCase.new);
    //PhoneValidation
    i.addLazySingleton<PhoneValidationBloc>(PhoneValidationBloc.new,
        config: blocConfig());
    i.addLazySingleton<PhoneValidationRepositoryInterface>(() =>
        PhoneValidationRepositoryImpl(
            i<HttpClientInterface>(), UrlInjector.instance));
    i.addLazySingleton<VerifyPhoneWithCodeUseCase>(
        VerifyPhoneWithCodeUseCase.new);

    //SendValidationSms
    i.addLazySingleton<SendValidationSmsBloc>(SendValidationSmsBloc.new,
        config: blocConfig());
    i.addLazySingleton<SendValidationSmsRepositoryInterface>(() =>
        SendValidationSmsRepositoryImpl(
            i<HttpClientInterface>(), UrlInjector.instance));
    //RevoverPassword
    i.addLazySingleton<RecoverPasswordBloc>(RecoverPasswordBloc.new,
        config: blocConfig());
    i.addLazySingleton<ResetPasswordUseCase>(ResetPasswordUseCase.new);
    //RegisterBloc
    i.addLazySingleton<RegisterBloc>(RegisterBloc.new, config: blocConfig());
    i.addLazySingleton<RegisterUseCase>(RegisterUseCase.new);
    //CommonUsecases
    i.addLazySingleton<SendVerificationCodeToPhoneUseCase>(
        SendVerificationCodeToPhoneUseCase.new);
  }

  @override
  void routes(r) {
    final NavigationInjector navigator = Modular.get<NavigationInjector>();
    navigator.setPaths(package: "authentication", pathList: {
      "root": "/",
      "reset_password": "/reset_password/",
      "phone_validation": "/phone_validation/",
      "send_validation_sms_page": "/send_validation_sms_page/",
      "register": "/register/",
    });
    r.child(navigator.getPath(package: "authentication", pathKey: "root"),
        child: (_) => LoginPage(
              authConfigDto: authConfigDto,
              homeUrl: homeUrl,
            ));
    r.child(
        navigator.getPath(package: "authentication", pathKey: "reset_password"),
        child: (_) => RecoverPasswordPage(
              authTextColor: authConfigDto.authTextColor,
            ));
    r.child(
        navigator.getPath(
            package: "authentication", pathKey: "send_validation_sms_page"),
        child: (_) => SendVaidationSmsPage(
              isoCode: authConfigDto.isoCode,
              authTextColor: authConfigDto.authTextColor,
            ));
    r.child(
        navigator.getPath(
            package: "authentication",
            pathKey: "phone_validation"), child: (_) {
      return PhoneValidationPage(
        authTextColor: authConfigDto.authTextColor,
      );
    });
    r.child(navigator.getPath(package: "authentication", pathKey: "register"),
        child: (_) => RegisterPage(
              authTextColor: authConfigDto.authTextColor,
            ));
  }
}
