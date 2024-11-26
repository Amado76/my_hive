// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// Perfis de usuário
class GroupDTO {
  final String? name;
  final String? name_profile;
  final String? dependent;
  final int? dependent_id;
  final int? community_id;
  final String? logo_url;
  final int? room_id;
  final String? room;

  const GroupDTO({
    required this.name,
    required this.name_profile,
    required this.community_id,
    required this.logo_url,
    required this.room_id,
    required this.room,
    required this.dependent,
    required this.dependent_id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'name_profile': name_profile,
      'community_id': community_id,
      'logo_url': logo_url,
      'room_id': room_id,
      'room': room,
      'dependent': dependent,
      'dependent_id': dependent_id,
    };
  }

  factory GroupDTO.fromMap(Map<String, dynamic> map) {
    return GroupDTO(
      dependent: map['dependent'] != null ? map['dependent'] as String : null,
      dependent_id:
          map['dependent_id'] != null ? map['dependent_id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      name_profile:
          map['name_profile'] != null ? map['name_profile'] as String : null,
      community_id:
          map['community_id'] != null ? map['community_id'] as int : null,
      logo_url: map['logo_url'] != null ? map['logo_url'] as String : null,
      room_id: map['room_id'] != null ? map['room_id'] as int : null,
      room: map['room'] != null ? map['room'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupDTO.fromJson(String source) =>
      GroupDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<GroupDTO> fromMapList(List<dynamic> mapList) {
    return mapList
        .map(
          (map) => GroupDTO.fromMap(
            map as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}
