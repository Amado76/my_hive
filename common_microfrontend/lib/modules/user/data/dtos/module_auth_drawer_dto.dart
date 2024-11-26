// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:common_microfrontend/modules/user/data/dtos/module_auth_dto.dart';

class ModuleAuthDrawerDTO extends ModuleAuthDTO {
  const ModuleAuthDrawerDTO({
    required super.id,
    required super.name,
    required super.app_route,
    required super.icon_lib,
    required super.icon_name,
    required super.is_authorized,
    required super.order,
  });

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

  factory ModuleAuthDrawerDTO.fromMap(Map<String, dynamic> map) {
    return ModuleAuthDrawerDTO(
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

  factory ModuleAuthDrawerDTO.fromJson(String source) =>
      ModuleAuthDrawerDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<ModuleAuthDrawerDTO> fromMapList(List<dynamic> mapList) {
    return mapList
        .map(
          (map) => ModuleAuthDrawerDTO.fromMap(
            map as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}
