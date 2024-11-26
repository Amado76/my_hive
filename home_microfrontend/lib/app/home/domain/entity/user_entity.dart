import 'package:common_microfrontend/common_microfrontend.dart';

class UserEntity extends Equatable {
  final String userAvatarPath;

  const UserEntity({
    required this.userAvatarPath,
  });

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      userAvatarPath: map['userAvatarPath'],
    );
  }

  @override
  List<Object?> get props => [userAvatarPath];
}
