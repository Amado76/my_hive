import 'package:flutter/material.dart';
import 'package:settings_microfrontend/app/domain/entities/settings_entity.dart';
import 'package:settings_microfrontend/app/domain/interfaces/settings_language_repository_interface.dart';

class GetSettingsLanguageUseCase {
  final SettingsLanguageRepositoryInterface _repository;

  GetSettingsLanguageUseCase(this._repository);

  Future<String> call() async {
    final SettingsEntity entity = await _repository.retrieve();
    if (entity.language == Language.system) {
      return WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    }
    return entity.language.name;
  }
}
