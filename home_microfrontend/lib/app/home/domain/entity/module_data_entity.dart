class ModuleDataEntity {
  final String moduleName;
  final String package;
  final String pathKey;
  final String? pathIcon;

  ModuleDataEntity(
      {required this.package,
      required this.pathKey,
      required this.moduleName,
      this.pathIcon});
}
