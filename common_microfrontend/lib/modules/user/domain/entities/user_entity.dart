// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:convert';

import 'package:common_microfrontend/modules/user/data/dtos/user_me_dto.dart';
import 'package:common_microfrontend/modules/user/data/dtos/user_profile_dto.dart';
import 'package:common_microfrontend/modules/user/domain/entities/module_auth_drawer_entity.dart';
import 'package:common_microfrontend/modules/user/domain/entities/module_auth_home_entity.dart';
import 'package:equatable/equatable.dart';
import 'group_entity.dart';

class UserEntity extends Equatable {
  // /apiv3/me/profile
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? phoneNumber;
  final String? email;
  final String? cpf;
  final String? birthdate;
  final String? description;
  final String? pictureUrl;
  final String? lastCommunityName;
  final String? nameProfile;
  final int? lastCommunityId;
  final int? roomId;
  final int? userId;
  List<GroupEntity> groups = [];
  List<ModuleAuthHomeEntity> modulesAuthHome = [];
  List<ModuleAuthDrawerEntity> modulesAuthDrawer = [];

  UserEntity({
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.cpf,
    required this.birthdate,
    required this.description,
    required this.pictureUrl,
    required this.nameProfile,
    required this.roomId,
    required this.groups,
    required this.modulesAuthHome,
    required this.modulesAuthDrawer,
    required this.lastCommunityName,
    required this.lastCommunityId,
    required this.userId,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        fullName,
        phoneNumber,
        email,
        cpf,
        birthdate,
        description,
        pictureUrl,
        nameProfile,
        roomId,
        userId,
        groups,
        modulesAuthHome,
        modulesAuthDrawer,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'cpf': cpf,
      'birthdate': birthdate,
      'description': description,
      'pictureUrl': pictureUrl,
      'nameProfile': nameProfile,
      'roomId': roomId,
      'groups': groups.map((x) => x.toMap()).toList(),
      'modulesAuthHome': modulesAuthHome.map((x) => x.toMap()).toList(),
      'modulesAuthDrawer': modulesAuthDrawer.map((x) => x.toMap()).toList(),
      'lastCommunityName': lastCommunityName,
      'lastCommunityId': lastCommunityId,
      'userId': userId,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      birthdate: map['birthdate'] != null ? map['birthdate'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      pictureUrl:
          map['pictureUrl'] != null ? map['pictureUrl'] as String : null,
      nameProfile:
          map['nameProfile'] != null ? map['nameProfile'] as String : null,
      roomId: map['roomId'] != null ? map['roomId'] as int : null,
      lastCommunityName: map['lastCommunityName'] != null
          ? map['lastCommunityName'] as String
          : null,
      lastCommunityId:
          map['lastCommunityId'] != null ? map['lastCommunityId'] as int : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      groups: List<GroupEntity>.from(
        (map['groups'] as List<dynamic>).map<GroupEntity>(
          (x) => GroupEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      modulesAuthHome: List<ModuleAuthHomeEntity>.from(
        (map['modulesAuthHome'] as List<dynamic>).map<ModuleAuthHomeEntity>(
          (x) => ModuleAuthHomeEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      modulesAuthDrawer: List<ModuleAuthDrawerEntity>.from(
        (map['modulesAuthDrawer'] as List<dynamic>).map<ModuleAuthDrawerEntity>(
          (x) => ModuleAuthDrawerEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  UserEntity copyWith({
    String? firstName,
    String? lastName,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? cpf,
    String? birthdate,
    String? description,
    String? pictureUrl,
    String? lastGroupName,
    String? nameProfile,
    int? roomId,
    List<GroupEntity>? groups,
    List<ModuleAuthHomeEntity>? modulesAuthHome,
    List<ModuleAuthDrawerEntity>? modulesAuthDrawer,
    String? lastCommunityName,
    int? lastCommunityId,
    int? userId,
  }) {
    return UserEntity(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      birthdate: birthdate ?? this.birthdate,
      description: description ?? this.description,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      nameProfile: nameProfile ?? this.nameProfile,
      roomId: roomId ?? this.roomId,
      groups: groups ?? this.groups,
      modulesAuthHome: modulesAuthHome ?? this.modulesAuthHome,
      modulesAuthDrawer: modulesAuthDrawer ?? this.modulesAuthDrawer,
      lastCommunityName: lastCommunityName ?? this.lastCommunityName,
      lastCommunityId: lastCommunityId ?? this.lastCommunityId,
      userId: userId ?? this.userId,
    );
  }

  static UserEntity fromUserMeDTO(UserMeDTO userMeDTO) {
    return UserEntity(
      firstName: userMeDTO.first_name,
      lastName: userMeDTO.last_name,
      fullName: userMeDTO.formatted_name,
      phoneNumber: userMeDTO.phone_number,
      email: userMeDTO.email,
      cpf: userMeDTO.cpf,
      birthdate: userMeDTO.birthdate,
      description: userMeDTO.description,
      pictureUrl: userMeDTO.picture,
      nameProfile: userMeDTO.name_profile,
      roomId: userMeDTO.room_id,
      groups: const [],
      modulesAuthHome: const [],
      modulesAuthDrawer: const [],
      lastCommunityName: userMeDTO.last_community_name,
      lastCommunityId: userMeDTO.last_community_id,
      userId: userMeDTO.user_id,
    );
  }

  static UserEntity fromUserProfileDTO(UserProfileDTO userProfileDTO) {
    return UserEntity(
      firstName: userProfileDTO.first_name,
      lastName: userProfileDTO.last_name,
      fullName: userProfileDTO.formatted_name,
      phoneNumber: userProfileDTO.phone_number,
      email: null,
      cpf: null,
      birthdate: null,
      description: userProfileDTO.description,
      pictureUrl: null,
      nameProfile: null,
      roomId: null,
      groups: const [],
      modulesAuthHome: const [],
      modulesAuthDrawer: const [],
      lastCommunityId: null,
      lastCommunityName: userProfileDTO.last_community_name,
      userId: null,
    );
  }

  static UserEntity combine(UserEntity entity1, UserEntity entity2) {
    return UserEntity(
      firstName: entity1.firstName ?? entity2.firstName,
      lastName: entity1.lastName ?? entity2.lastName,
      fullName: entity1.fullName ?? entity2.fullName,
      phoneNumber: entity1.phoneNumber ?? entity2.phoneNumber,
      email: entity1.email ?? entity2.email,
      cpf: entity1.cpf ?? entity2.cpf,
      birthdate: entity1.birthdate ?? entity2.birthdate,
      description: entity1.description ?? entity2.description,
      pictureUrl: entity1.pictureUrl ?? entity2.pictureUrl,
      nameProfile: entity1.nameProfile ?? entity2.nameProfile,
      roomId: entity1.roomId ?? entity2.roomId,
      groups: const [],
      modulesAuthHome: const [],
      modulesAuthDrawer: const [],
      lastCommunityName: entity1.lastCommunityName ?? entity2.lastCommunityName,
      lastCommunityId: entity1.lastCommunityId ?? entity2.lastCommunityId,
      userId: entity1.userId ?? entity2.userId,
    );
  }
}
