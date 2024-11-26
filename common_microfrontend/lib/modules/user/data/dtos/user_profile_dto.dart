// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class UserProfileDTO {
  final String? first_name;
  final String? last_name;
  final String? formatted_name;
  final String? phone_number;
  final String? email;
  final String? cpf;
  final String? birthdate;
  final String? description;
  final String? picture_url;
  final String? last_community_name;

  UserProfileDTO({
    required this.first_name,
    required this.last_name,
    required this.formatted_name,
    required this.phone_number,
    required this.email,
    required this.cpf,
    required this.birthdate,
    required this.description,
    required this.picture_url,
    required this.last_community_name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': first_name,
      'last_name': last_name,
      'formatted_name': formatted_name,
      'phone_number': phone_number,
      'email': email,
      'cpf': cpf,
      'birthdate': birthdate,
      'description': description,
      'picture_url': picture_url,
      'last_community_name': last_community_name,
    };
  }

  factory UserProfileDTO.fromMap(Map<String, dynamic> map) {
    return UserProfileDTO(
      first_name:
          map['first_name'] != null ? map['first_name'] as String : null,
      last_name: map['last_name'] != null ? map['last_name'] as String : null,
      formatted_name: map['formatted_name'] != null
          ? map['formatted_name'] as String
          : null,
      phone_number:
          map['phone_number'] != null ? map['phone_number'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      birthdate: map['birthdate'] != null ? map['birthdate'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      picture_url:
          map['picture_url'] != null ? map['picture_url'] as String : null,
      last_community_name: map['last_community_name'] != null
          ? map['last_community_name'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileDTO.fromJson(String source) =>
      UserProfileDTO.fromMap(json.decode(source) as Map<String, dynamic>);
}
