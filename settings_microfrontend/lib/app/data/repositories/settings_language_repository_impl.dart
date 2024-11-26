import 'package:common_microfrontend/util/secure_local_storage/secure_local_storage_adapter.dart';
import 'package:settings_microfrontend/app/domain/entities/settings_entity.dart';
import 'package:settings_microfrontend/app/domain/interfaces/settings_language_repository_interface.dart';

class SettingsLanguageRepositoryImpl
    implements SettingsLanguageRepositoryInterface {
  final SecureLocalStorageInterface _settingsDataSource;

  SettingsLanguageRepositoryImpl({
    required SecureLocalStorageInterface settingsDataSource,
  }) : _settingsDataSource = settingsDataSource;

  @override
  Future<SettingsEntity> retrieve() async {
    final String? language = await _settingsDataSource.get(key: 'language');

    const List<Language> languages = Language.values;
    for (final Language lang in languages) {
      if (lang.toString() == language) {
        return SettingsEntity(language: lang);
      }
    }

    return SettingsEntity(language: Language.system);
  }

  @override
  Future<void> save({required Language language}) async {
    await _settingsDataSource.save(
      key: 'language',
      value: language.toString(),
    );
  }
}
