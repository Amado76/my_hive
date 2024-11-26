import 'package:my_profile_microfrontend/app/core/domain/dto/profile_dto.dart';
import 'package:my_profile_microfrontend/app/core/domain/repository/my_profile_repository_interface.dart';

class UpdateProfileUseCase {
  final MyProfileRepositoryInterface _profileRepository;

  UpdateProfileUseCase(this._profileRepository);

  Future<void> call({required ProfileDto profileDto, int? studentId}) async {
    await _profileRepository.updateProfile(profileDto, studentId);
  }
}
