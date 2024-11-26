class SettingsEntity {
  final Language language;

  SettingsEntity({
    required this.language,
  });
}

enum Language {
  system,
  pt,
  en,
  es,
}

extension LanguageExtension on Language {
  String get name {
    switch (this) {
      case Language.system:
        return 'system';
      case Language.pt:
        return 'pt';
      case Language.en:
        return 'en';
      case Language.es:
        return 'es';
    }
  }

  String get nameToUI {
    switch (this) {
      case Language.system:
        return 'System';
      case Language.pt:
        return 'Português BR';
      case Language.en:
        return 'English';
      case Language.es:
        return 'Español';
    }
  }
}
