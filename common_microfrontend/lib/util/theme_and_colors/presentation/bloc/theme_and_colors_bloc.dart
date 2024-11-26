import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/material.dart';

import 'package:common_microfrontend/util/theme_and_colors/data/theme_dto.dart';
import 'package:common_microfrontend/util/theme_and_colors/presentation/widgets/theme_data_factory.dart';

part 'theme_and_colors_event.dart';
part 'theme_and_colors_state.dart';

class ThemeAndColorsBloc
    extends Bloc<AbstractThemeAndColorsEvent, ThemeAndColorsState> {
  ThemeAndColorsBloc()
      : super(
          const ThemeAndColorsStateInitial(),
        ) {
    on<ThemeToogleModeEvent>(
      (
        ThemeToogleModeEvent event,
        Emitter<ThemeAndColorsState> emit,
      ) {
        if (state is ThemeAndColorsStateSuccess) {
          final ThemeAndColorsState themeAndColorsState =
              state as ThemeAndColorsStateSuccess;
          emit(ThemeAndColorsStateSuccess(
            themeMode: themeAndColorsState.themeMode == ThemeMode.dark
                ? ThemeMode.light
                : ThemeMode.dark,
            themeData: themeAndColorsState.themeData,
          ));
        }
      },
    );

    on<ThemeChangeThemeEvent>(
      (
        ThemeChangeThemeEvent event,
        Emitter<ThemeAndColorsState> emit,
      ) async {
        // if (state is ThemeAndColorsStateSuccess) {
        emit(const ThemeAndColorsStateLoading());

        final ThemeDto? themeDto = await Modular.get<ChangeThemeUsecase>()();

        final ThemeData themeData = ThemeDataFactory.createThemeData(
            themeDto ?? ThemeDto.defaultTheme(themeMode: event.themeMode));

        emit(
          ThemeAndColorsStateSuccess(
            themeMode: state.themeMode,
            themeData: themeData,
          ),
        );
      },
    );
  }

  void toggleThemeMode() {
    add(ThemeToogleModeEvent());
  }

  void changeTheme({String themeMode = 'light'}) {
    add(ThemeChangeThemeEvent(themeMode: themeMode));
  }
}
