// ignore_for_file: non_constant_identifier_names

abstract class ModuleAuthDTO {
  final int? id;
  final String? name;
  final String? app_route;
  final String? icon_lib;
  final String? icon_name;
  final bool? is_authorized;
  final int? order;

  const ModuleAuthDTO({
    required this.id,
    required this.name,
    required this.app_route,
    required this.icon_lib,
    required this.icon_name,
    required this.is_authorized,
    required this.order,
  });
}
