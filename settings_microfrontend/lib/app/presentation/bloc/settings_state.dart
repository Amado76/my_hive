part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {}

final class SettingsSuccessState extends SettingsState {
  final SettingsEntity settings;

  SettingsSuccessState({required this.settings});

  @override
  List<Object?> get props => [settings];
}

final class SettingsLoadingState extends SettingsState {
  @override
  List<Object?> get props => [];
}

final class SettingsErrorState extends SettingsState {
  final String message;

  SettingsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
