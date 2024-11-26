import 'package:flutter/material.dart';
import 'package:common_microfrontend/util/exception/gtec_exception.dart';
import 'package:common_microfrontend/util/url_injector/url_injector_object.dart';

class UrlInjector {
  static final UrlInjector _instance = UrlInjector._internal();

  UrlInjector._internal();

  static UrlInjector get instance => _instance;

  String? _baseUrl;
  Map<String, String> endpoints = {};

  void setBaseUrl({required String url}) {
    if (_baseUrl == null) {
      _baseUrl = url;
    } else {
      throw GTecException(message: 'Base URL already set');
    }
  }

  String getEndPoint({required String endpoint, required String package}) {
    final String key =
        generateKey(package: package, endpointIdentifier: endpoint);
    if (_baseUrl == null) {
      throw GTecException(message: 'Base URL not set');
    }
    if (!endpoints.containsKey(key)) {
      throw GTecException(message: 'Endpoint not found');
    }
    return _baseUrl! + endpoints[key]!;
  }

  void registerUrl(UrlInjectorObject urlInjectorObject) {
    var objects = UrlInjectorObject.fromMapData(urlInjectorObject.mapData);
    for (var obj in objects) {
      if (obj is UrlInjectorObjectImpl) {
        String key = generateKey(
            package: obj.package, endpointIdentifier: obj.endpointIdentifier);
        setEndpoints(endpointsList: {key: obj.endpoint});
      }
    }
  }

  @visibleForTesting
  String generateKey(
      {required String package, required String endpointIdentifier}) {
    return '$package-$endpointIdentifier';
  }

  @visibleForTesting
  setEndpoints({required Map<String, String> endpointsList}) {
    // for (String key in endpointsList.keys) {
    //   if (endpoints.containsKey(key)) {
    //     throw GTecException(message: 'Endpoint already set');
    //   }
    // }
    endpoints.addAll(endpointsList);
  }

  @visibleForTesting
  String getBaseUrl() {
    return _baseUrl!;
  }

  @visibleForTesting
  static void reset() {
    _instance._baseUrl = null;
    _instance.endpoints.clear();
  }
}
