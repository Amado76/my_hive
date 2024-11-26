// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class UserMeDTO {
  final String? formatted_name;
  final String? cpf;
  final String? birthdate;
  final String? picture;
  final String? last_community_name;
  final String? name_profile;
  final int? last_community_id;
  final int? room_id;
  final String? email;

  final int? user_id;

  final String? first_name;
  final String? last_name;
  final String? phone_number;
  final String? description;
  final String? picture_url;

  const UserMeDTO({
    required this.formatted_name,
    required this.cpf,
    required this.birthdate,
    required this.picture,
    required this.name_profile,
    required this.room_id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.phone_number,
    required this.description,
    required this.picture_url,
    required this.last_community_name,
    required this.last_community_id,
    required this.user_id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'formatted_name': formatted_name,
      'cpf': cpf,
      'birthdate': birthdate,
      'picture': picture,
      'name_profile': name_profile,
      'room_id': room_id,
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'phone_number': phone_number,
      'description': description,
      'picture_url': picture_url,
      'last_community_name': last_community_name,
      'last_community_id': last_community_id,
      'user_id': user_id,
    };
  }

  factory UserMeDTO.fromMap(Map<String, dynamic> map) {
    return UserMeDTO(
      user_id: map['user_id'] != null ? map['user_id'] as int : null,
      last_community_name: map['last_community_name'] != null
          ? map['last_community_name'] as String
          : null,
      last_community_id: map['last_community_id'] != null
          ? map['last_community_id'] as int
          : null,
      formatted_name: map['formatted_name'] != null
          ? map['formatted_name'] as String
          : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      birthdate: map['birthdate'] != null ? map['birthdate'] as String : null,
      picture: map['picture'] != null ? map['picture'] as String : null,
      name_profile:
          map['name_profile'] != null ? map['name_profile'] as String : null,
      room_id: map['room_id'] != null ? map['room_id'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      first_name:
          map['first_name'] != null ? map['first_name'] as String : null,
      last_name: map['last_name'] != null ? map['last_name'] as String : null,
      phone_number:
          map['phone_number'] != null ? map['phone_number'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      picture_url:
          map['picture_url'] != null ? map['picture_url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserMeDTO.fromJson(String source) =>
      UserMeDTO.fromMap(json.decode(source) as Map<String, dynamic>);
}
