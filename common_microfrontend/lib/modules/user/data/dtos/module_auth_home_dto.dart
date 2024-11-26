// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:common_microfrontend/modules/user/data/dtos/module_auth_dto.dart';
import 'package:common_microfrontend/modules/user/domain/entities/module_auth_home_entity.dart';

class ModuleAuthHomeDTO extends ModuleAuthDTO {
  const ModuleAuthHomeDTO({
    required super.id,
    required super.name,
    required super.app_route,
    required super.icon_lib,
    required super.icon_name,
    required super.is_authorized,
    required super.order,
  });

  ModuleAuthHomeEntity toEntity() {
    return ModuleAuthHomeEntity(
      id: id,
      name: name,
      appRoute: app_route,
      iconLib: icon_lib,
      iconName: icon_name,
      isAuthorized: is_authorized,
      order: order,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'app_route': app_route,
      'icon_lib': icon_lib,
      'icon_name': icon_name,
      'is_authorized': is_authorized,
      'order': order,
    };
  }

  factory ModuleAuthHomeDTO.fromMap(Map<String, dynamic> map) {
    return ModuleAuthHomeDTO(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      app_route: map['app_route'] != null ? map['app_route'] as String : null,
      icon_lib: map['icon_lib'] != null ? map['icon_lib'] as String : null,
      icon_name: map['icon_name'] != null ? map['icon_name'] as String : null,
      is_authorized:
          map['is_authorized'] != null ? map['is_authorized'] as bool : null,
      order: map['order'] != null ? map['order'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModuleAuthHomeDTO.fromJson(String source) =>
      ModuleAuthHomeDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<ModuleAuthHomeDTO> fromMapList(List<dynamic> mapList) {
    return mapList
        .map(
          (map) => ModuleAuthHomeDTO.fromMap(
            map as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}
