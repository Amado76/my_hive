// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:common_microfrontend/modules/user/data/dtos/group_dto.dart';
import 'package:equatable/equatable.dart';

class GroupEntity extends Equatable {
  final String? name;
  final String? nameProfile;
  final String? dependent;
  final int? dependentId;
  final int? communityId;
  final String? logoUrl;

  final int? roomId;
  final String? room;

  const GroupEntity({
    required this.name,
    required this.nameProfile,
    required this.communityId,
    required this.logoUrl,
    required this.roomId,
    required this.room,
    required this.dependent,
    required this.dependentId,
  });

  @override
  List<Object?> get props => [
        name,
        nameProfile,
        communityId,
        logoUrl,
        roomId,
        room,
        dependent,
        dependentId,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'nameProfile': nameProfile,
      'communityId': communityId,
      'logoUrl': logoUrl,
      'roomId': roomId,
      'room': room,
      'dependent': dependent,
      'dependentId': dependentId,
    };
  }

  factory GroupEntity.fromMap(Map<String, dynamic> map) {
    return GroupEntity(
      dependent: map['dependent'] != null ? map['dependent'] as String : null,
      dependentId:
          map['dependentId'] != null ? map['dependentId'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      nameProfile:
          map['nameProfile'] != null ? map['nameProfile'] as String : null,
      communityId:
          map['communityIdId'] != null ? map['communityId'] as int : null,
      logoUrl: map['logoUrl'] != null ? map['logoUrl'] as String : null,
      roomId: map['roomId'] != null ? map['roomId'] as int : null,
      room: map['room'] != null ? map['room'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupEntity.fromJson(String source) =>
      GroupEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  GroupEntity copyWith({
    String? name,
    String? nameProfile,
    int? communityId,
    String? logoUrl,
    int? roomId,
    String? room,
    String? dependent,
    int? dependentId,
  }) {
    return GroupEntity(
      dependent: dependent ?? this.dependent,
      dependentId: dependentId ?? this.dependentId,
      name: name ?? this.name,
      nameProfile: nameProfile ?? this.nameProfile,
      communityId: communityId ?? this.communityId,
      logoUrl: logoUrl ?? this.logoUrl,
      roomId: roomId ?? this.roomId,
      room: room ?? this.room,
    );
  }

  static fromDTO(GroupDTO groupDTO) {
    return GroupEntity(
      dependent: groupDTO.dependent,
      dependentId: groupDTO.dependent_id,
      name: groupDTO.name,
      nameProfile: groupDTO.name_profile,
      communityId: groupDTO.community_id,
      logoUrl: groupDTO.logo_url,
      roomId: groupDTO.room_id,
      room: groupDTO.room,
    );
  }
}
