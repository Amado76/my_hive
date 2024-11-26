class UserDataDTO {
  final String userAvatarPath;

  UserDataDTO({
    required this.userAvatarPath,
  });

  factory UserDataDTO.fromJson(Map<String, dynamic> json) {
    return UserDataDTO(
      userAvatarPath: json['user_avatar'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userAvatarPath': userAvatarPath,
    };
  }
}
