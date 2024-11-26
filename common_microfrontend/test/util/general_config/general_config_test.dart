import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

class MockHttpClientInterface extends Mock implements DioAdapter {}

class MockUrlInjector extends Mock implements UrlInjector {}

void main() {
  group('[GeneralConfig Tests]', () {
    // late MockHttpClientInterface mockHttpClient;
    // late MockUrlInjector mockUrlInjector;

    setUp(() {
      // mockHttpClient = MockHttpClientInterface();
      // mockUrlInjector = MockUrlInjector();
    });
    test('should return an AuthUserEntity instance for authUserEntity property',
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterSecureStorage.setMockInitialValues({});

      Modular.bindModule(GeneralConfigModular());

      UrlInjector urlInjector = Modular.get<UrlInjector>();
      urlInjector.setBaseUrl(url: 'https://example.com');

      GeneralConfig gc = Modular.get<GeneralConfig>();
      gc.reset();
      gc.business = 'business';
      gc.language = 'pt';

      SaveUserTokenUseCase(Modular.get<AuthUserRepositoryInterface>())(
        'tokenabc',
      );

      await expectLater(
        gc.authUserRepo!.authTokenStream,
        emits(predicate<AuthUserEntity>(
            (entity) => entity.accessToken == 'tokenabc')),
      );
    });
    test('should initialize GeneralConfig', () async {
      WidgetsFlutterBinding.ensureInitialized();

      Modular.bindModule(GeneralConfigModular());

      GeneralConfig gc = Modular.get<GeneralConfig>();
      gc.reset();
      gc.business = 'business';
      gc.language = 'pt';

      expect(gc.business, equals('business'));
      expect(gc.language, equals('pt'));
    });
  });

  test('should throw GTecException when business is already set', () {
    WidgetsFlutterBinding.ensureInitialized();

    Modular.bindModule(GeneralConfigModular());

    GeneralConfig gc = Modular.get<GeneralConfig>();
    gc.reset();
    gc.business = 'business';

    expect(() => gc.business = 'business', throwsA(isA<GTecException>()));
  });

  test('should throw GTecException when business is not set', () {
    WidgetsFlutterBinding.ensureInitialized();

    Modular.bindModule(GeneralConfigModular());

    GeneralConfig gc = Modular.get<GeneralConfig>();
    gc.reset();

    expect(() => gc.business, throwsA(isA<GTecException>()));
  });

  test('should throw GTecException when language is not set', () {
    WidgetsFlutterBinding.ensureInitialized();

    Modular.bindModule(GeneralConfigModular());

    GeneralConfig gc = Modular.get<GeneralConfig>();
    gc.reset();

    expect(() => gc.language, throwsA(isA<GTecException>()));
  });
}

class GeneralConfigModular extends Module {
  @override
  List<Module> get imports => [
        CommonModule(),
      ];
}
