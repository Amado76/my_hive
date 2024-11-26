// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:common_microfrontend/util/exception/gtec_exception.dart';

class NavigationInjector {
  // static final NavigationInjector _instance = NavigationInjector._internal();
  // NavigationInjector._internal();
  // static NavigationInjector get instance => _instance;

  Map<String, Map<String, String>> packagePaths = {};

  void setPaths(
      {required String package, required Map<String, String> pathList}) {
    if (!packagePaths.containsKey(package)) {
      packagePaths[package] = {};
    }

    Map<String, String> currentPaths = packagePaths[package]!;

    pathList.forEach((key, value) {
      if (currentPaths.containsKey(key)) {
        throw GTecException(
            message: 'Path key "$key" already set in package "$package".');
      }

      if (currentPaths.containsValue(value)) {
        throw GTecException(
            message: 'Path value "$value" already set in package "$package".');
      }

      currentPaths[key] = value;
    });
  }

  String getPath({required String package, required String pathKey}) {
    if (!packagePaths.containsKey(package) ||
        !packagePaths[package]!.containsKey(pathKey)) {
      throw GTecException(
          message: 'Path "$pathKey" not found in package "$package".');
    }
    final String path = packagePaths[package]![pathKey]!;

    return path;
  }

  String getRelativePath({required String package, required String pathKey}) {
    if (!packagePaths.containsKey(package) ||
        !packagePaths[package]!.containsKey(pathKey)) {
      throw GTecException(
          message: 'Path "$pathKey" not found in package "$package".');
    }

    final String path = '.${packagePaths[package]![pathKey]!}';
    return path;
  }

  String getPathInPackage({required String package, required String pathKey}) {
    if (!packagePaths.containsKey(package) ||
        !packagePaths[package]!.containsKey(pathKey)) {
      throw GTecException(
          message: 'Path "$pathKey" not found in package "$package".');
    }
    final String path = '/$package${packagePaths[package]![pathKey]!}';
    return path;
  }

  @visibleForTesting
  void reset() {
    packagePaths.clear();
  }
}
