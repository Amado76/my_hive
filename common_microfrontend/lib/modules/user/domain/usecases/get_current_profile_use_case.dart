import 'package:common_microfrontend/modules/user/domain/entities/group_entity.dart';
import 'package:common_microfrontend/modules/user/domain/entities/user_entity.dart';
import 'package:common_microfrontend/util/exception/gtec_exception.dart';
import 'package:common_microfrontend/util/general_config/general_config.dart';

class GetCurrentProfileUseCase {
  final GeneralConfig _gc;

  GetCurrentProfileUseCase(this._gc);

  GroupEntity call() {
    if (_gc.userEntity == null) {
      throw Exception(
          'UserEntity of General Config is null. Before use it, General Config init()');
    }

    final UserEntity userEntity = _gc.userEntity!;
    final List<GroupEntity> allProfiles = userEntity.groups;

    return allProfiles.firstWhere(
      (GroupEntity profile) =>
          profile.name == userEntity.lastCommunityName &&
          profile.communityId == userEntity.lastCommunityId &&
          profile.roomId == userEntity.roomId,
      orElse: () => throw GTecException(
        message: 'profileNotFoundForUser',
      ),
    );
  }
}
