abstract class TranslationObject {
  // jsonData deve ser fornecido pelas classes filhas
  List<Map<String, dynamic>> get jsonData;

  // Método para converter o jsonData (fornecido pelas classes filhas) em TranslationObject
  static List<TranslationObject> fromJsonData(
    List<Map<String, dynamic>> jsonData,
  ) {
    return jsonData
        .map((map) => TranslationObjectImpl(
              language: map['language'],
              business: map['business'], // Note a grafia
              package: map['package'],
              translations: Map<String, String>.from(map['translate']),
            ))
        .toList();
  }
}

// Implementação concreta de TranslationObject para uso interno
class TranslationObjectImpl extends TranslationObject {
  @override
  final List<Map<String, dynamic>> jsonData; // Não será usado nesta classe

  final String language;
  final String business;
  final String package;
  final Map<String, String> translations;

  TranslationObjectImpl({
    required this.language,
    required this.business,
    required this.package,
    required this.translations,
  }) : jsonData = [];
}
