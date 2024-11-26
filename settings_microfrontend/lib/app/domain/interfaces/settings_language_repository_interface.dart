import 'package:settings_microfrontend/app/domain/entities/settings_entity.dart';

abstract class SettingsLanguageRepositoryInterface {
  Future<void> save({required Language language});
  Future<SettingsEntity> retrieve();
}
