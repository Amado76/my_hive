part of 'theme_and_colors_bloc.dart';

@immutable
sealed class ThemeAndColorsState extends Equatable {
  final ThemeMode? themeMode;
  final ThemeData? themeData;

  const ThemeAndColorsState({
    required this.themeMode,
    required this.themeData,
  });

  @override
  List<Object?> get props => [themeMode, themeData];
}

class ThemeAndColorsStateSuccess extends ThemeAndColorsState {
  const ThemeAndColorsStateSuccess({
    required super.themeMode,
    required super.themeData,
  });
}

class ThemeAndColorsStateInitial extends ThemeAndColorsState {
  const ThemeAndColorsStateInitial()
      : super(
          themeMode: null,
          themeData: null,
        );
}

class ThemeAndColorsStateLoading extends ThemeAndColorsState {
  const ThemeAndColorsStateLoading()
      : super(
          themeMode: null,
          themeData: null,
        );
}
