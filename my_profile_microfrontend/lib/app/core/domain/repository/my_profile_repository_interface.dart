import 'package:my_profile_microfrontend/app/core/domain/dto/profile_dto.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/my_profile_entity.dart';

abstract class MyProfileRepositoryInterface {
  Future<MyProfileEntity> getProfile();
  Future<void> updateProfile(ProfileDto updateDto, int? studentId);
}
