part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {}

class GetSettingsEvent extends SettingsEvent {
  @override
  List<Object?> get props => [];
}

class ChangeSettingsEvent extends SettingsEvent {
  final SettingsEntity settings;

  ChangeSettingsEvent({required this.settings});

  @override
  List<Object?> get props => [settings];
}
