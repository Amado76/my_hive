import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:faker/faker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/util/http_client/interceptors/auth_token_interceptor.dart';
import 'package:mocktail/mocktail.dart';

class RequestOptionsMock extends Mock implements RequestOptions {}

class RequestInterceptorHandlerMock extends Mock
    implements RequestInterceptorHandler {}

class GeneralConfigMock extends Mock implements GeneralConfig {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Modular.bindModule(GeneralConfigModular());

  GeneralConfig gc = Modular.get<GeneralConfig>();
  gc.reset();
  gc.business = 'business';
  gc.language = 'pt';

  group('[AuthTokenInterceptor Tests]', () {
    final interceptor = AuthTokenInterceptor();
    final authToken = faker.guid.guid();

    test(
      "should ignore the interceptor when the 'skipAuthTokenInterceptor' is true",
      () async {
        final interceptor = AuthTokenInterceptor();
        final request = RequestOptionsMock();
        final handler = RequestInterceptorHandlerMock();

        when(() => request.extra)
            .thenReturn({'skipAuthTokenInterceptor': true});

        when(() => request.headers).thenReturn({});

        interceptor.onRequest(request, handler);
        verify(() => handler.next(request));
        verifyNever(() => request.headers['Authorization']);
      },
    );

    test('should return an AuthUserEntity instance for authUserEntity property',
        () async {
      FlutterSecureStorage.setMockInitialValues({});
      SaveUserTokenUseCase(Modular.get<AuthUserRepositoryInterface>())(
        authToken,
      );
      final request = RequestOptionsMock();
      final handler = RequestInterceptorHandlerMock();

      when(() => request.headers).thenReturn({});
      when(() => request.extra).thenReturn({'skipAuthTokenInterceptor': false});

      // O teste deve esperar que o stream sete o valor do token
      await expectLater(
        gc.authUserRepo!.authTokenStream,
        emits(predicate<AuthUserEntity>(
            (entity) => entity.accessToken == authToken)),
      );

      // Com o token setado, o interceptor deve adicionar o token ao header
      interceptor.onRequest(request, handler);
      verify(() => handler.next(request)).called(1);
      verify(() => request.headers['Authorization']).called(1);
      expect(request.headers['Authorization'], equals('JWT $authToken'));
    });
  });
}

class GeneralConfigModular extends Module {
  @override
  List<Module> get imports => [
        CommonModule(),
      ];
}
