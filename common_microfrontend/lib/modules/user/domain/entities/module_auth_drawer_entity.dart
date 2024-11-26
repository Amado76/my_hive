import 'dart:convert';

import 'package:common_microfrontend/modules/user/data/dtos/module_auth_drawer_dto.dart';
import 'package:common_microfrontend/modules/user/domain/entities/module_auth_entity.dart';

class ModuleAuthDrawerEntity extends ModuleAuthEntity {
  const ModuleAuthDrawerEntity({
    required super.id,
    required super.name,
    required super.appRoute,
    required super.iconLib,
    required super.iconName,
    required super.isAuthorized,
    required super.order,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'appRoute': appRoute,
      'iconLib': iconLib,
      'iconName': iconName,
      'isAuthorized': isAuthorized,
      'order': order,
    };
  }

  factory ModuleAuthDrawerEntity.fromMap(Map<String, dynamic> map) {
    return ModuleAuthDrawerEntity(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      appRoute: map['appRoute'] != null ? map['appRoute'] as String : null,
      iconLib: map['iconLib'] != null ? map['iconLib'] as String : null,
      iconName: map['iconName'] != null ? map['iconName'] as String : null,
      isAuthorized:
          map['isAuthorized'] != null ? map['isAuthorized'] as bool : null,
      order: map['order'] != null ? map['order'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModuleAuthDrawerEntity.fromJson(String source) =>
      ModuleAuthDrawerEntity.fromMap(
          json.decode(source) as Map<String, dynamic>);

  ModuleAuthDrawerEntity copyWith({
    int? id,
    String? name,
    String? appRoute,
    String? iconLib,
    String? iconName,
    bool? isAuthorized,
    int? order,
  }) {
    return ModuleAuthDrawerEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      appRoute: appRoute ?? this.appRoute,
      iconLib: iconLib ?? this.iconLib,
      iconName: iconName ?? this.iconName,
      isAuthorized: isAuthorized ?? this.isAuthorized,
      order: order ?? this.order,
    );
  }

  static fromDTO(ModuleAuthDrawerDTO moduleAuthDrawerDTO) {
    return ModuleAuthDrawerEntity(
      id: moduleAuthDrawerDTO.id,
      name: moduleAuthDrawerDTO.name,
      appRoute: moduleAuthDrawerDTO.app_route,
      iconLib: moduleAuthDrawerDTO.icon_lib,
      iconName: moduleAuthDrawerDTO.icon_name,
      isAuthorized: moduleAuthDrawerDTO.is_authorized,
      order: moduleAuthDrawerDTO.order,
    );
  }
}
