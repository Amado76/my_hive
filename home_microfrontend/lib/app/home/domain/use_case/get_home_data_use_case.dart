import 'package:home_microfrontend/app/home/data/dto/home_data_dto.dart';
import 'package:home_microfrontend/app/home/domain/entity/banner_entity.dart';
import 'package:home_microfrontend/app/home/domain/repository/home_repository_interface.dart';
import 'package:home_microfrontend/app/home/domain/entity/user_entity.dart';

class GetHomeDataUseCase {
  final HomeRepositoryInterface _homeRepository;

  GetHomeDataUseCase(this._homeRepository);

  Future<({UserEntity userEntity, List<BannerEntity> bannerEntityList})>
      call() async {
    HomeDataDto homeDataDto = await _homeRepository.getHomeData();

    UserEntity userEntity = UserEntity.fromMap(homeDataDto.userData.toMap());
    List<BannerEntity> bannerEntityList = homeDataDto.bannerData
        .map((e) => BannerEntity.fromMap(e.toMap()))
        .toList();

    return (userEntity: userEntity, bannerEntityList: bannerEntityList);
  }
}
