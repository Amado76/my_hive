part of 'theme_and_colors_bloc.dart';

@immutable
sealed class AbstractThemeAndColorsEvent extends Equatable {}

final class ThemeToogleModeEvent extends AbstractThemeAndColorsEvent {
  @override
  List<Object?> get props => [];
}

@immutable
final class ThemeChangeThemeEvent extends AbstractThemeAndColorsEvent {
  final String themeMode;
  ThemeChangeThemeEvent({
    this.themeMode = 'light',
  });
  @override
  List<Object?> get props => [];
}
