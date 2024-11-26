abstract class UrlInjectorObject {
  // jsonData deve ser fornecido pelas classes filhas
  List<Map<String, dynamic>> get mapData;

  // Método para converter o jsonData (fornecido pelas classes filhas) em UrlInjectorObjectImpl
  static List<UrlInjectorObject> fromMapData(
      List<Map<String, dynamic>> mapData) {
    return mapData
        .map((map) => UrlInjectorObjectImpl(
              package: map['package'],
              endpointIdentifier: map['endpointIdentifier'],
              endpoint: map['endpoint'],
            ))
        .toList();
  }
}

// Implementação concreta de UrlInjectorObjectImpl para uso interno
class UrlInjectorObjectImpl extends UrlInjectorObject {
  @override
  final List<Map<String, dynamic>> mapData; // Não será usado nesta classe

  final String endpointIdentifier;
  final String package;
  final String endpoint;

  UrlInjectorObjectImpl(
      {required this.endpointIdentifier,
      required this.endpoint,
      required this.package})
      : mapData = [];
}
