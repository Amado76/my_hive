import 'package:my_profile_microfrontend/app/core/domain/entities/my_profile_entity.dart';
import 'package:my_profile_microfrontend/app/core/domain/repository/my_profile_repository_interface.dart';

class GetProfileUseCase {
  final MyProfileRepositoryInterface _profileRepository;

  GetProfileUseCase(this._profileRepository);

  Future<MyProfileEntity> call() async {
    return await _profileRepository.getProfile();
  }
}
