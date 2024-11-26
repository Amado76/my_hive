import 'package:common_microfrontend/modules/user/domain/entities/group_entity.dart';

abstract class GroupRepositoryInterface {
  Future<List<GroupEntity?>> getGroup();
}
