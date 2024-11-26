import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:common_microfrontend/util/theme_and_colors/presentation/widgets/theme_data_factory.dart';
import 'package:mocktail/mocktail.dart';

class MockChangeThemeUsecase extends Mock implements ChangeThemeUsecase {}

class MockThemeDataFactory extends Mock implements ThemeDataFactory {}

class GeneralConfigModular extends Module {
  @override
  List<Module> get imports => [
        CommonModule(),
      ];
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Modular.bindModule(GeneralConfigModular());

  GeneralConfig gc = Modular.get<GeneralConfig>();
  gc.reset();
  gc.business = GeneralBusiness.education;
  gc.language = 'en';

  UrlInjector urlInjector = Modular.get<UrlInjector>();
  urlInjector.setBaseUrl(url: 'https://example.com');

  group('ThemeAndColorsBloc', () {
    late ThemeAndColorsBloc bloc;
    // late MockChangeThemeUsecase mockChangeThemeUsecase;

    setUp(() {
      // mockChangeThemeUsecase = MockChangeThemeUsecase();
      bloc = ThemeAndColorsBloc();
    });

    test('initial state is ThemeAndColorsStateInitial', () {
      expect(bloc.state, isA<ThemeAndColorsStateInitial>());
    });

    // blocTest<ThemeAndColorsBloc, ThemeAndColorsState>(
    //   'emits [ThemeAndColorsStateLoading, ThemeAndColorsStateSuccess] on ThemeChangeThemeEvent',
    //   build: () => bloc,
    //   act: (bloc) {
    //     when(() => mockChangeThemeUsecase())
    //         .thenAnswer((_) async => ThemeDto.defaultTheme());
    //     bloc.add(ThemeChangeThemeEvent());
    //   },
    //   expect: () => [
    //     isA<ThemeAndColorsStateLoading>(),
    //     isA<ThemeAndColorsStateSuccess>()
    //   ],
    // );

    blocTest<ThemeAndColorsBloc, ThemeAndColorsState>(
      'toggles theme mode correctly on ThemeToggleModeEvent when state is ThemeAndColorsStateSuccess',
      build: () => bloc,
      seed: () => ThemeAndColorsStateSuccess(
          themeMode: ThemeMode.light, themeData: ThemeData.light()),
      act: (bloc) => bloc.add(ThemeToogleModeEvent()),
      expect: () => [
        isA<ThemeAndColorsStateSuccess>()
            .having((s) => s.themeMode, 'themeMode', ThemeMode.dark)
      ],
    );
  });
}
