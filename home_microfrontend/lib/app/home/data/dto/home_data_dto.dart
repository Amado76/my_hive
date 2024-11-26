import 'package:home_microfrontend/app/home/data/dto/banner_data_dto.dart';
import 'package:home_microfrontend/app/home/data/dto/user_data_dto.dart';

class HomeDataDto {
  final UserDataDTO userData;
  final List<BannerDataDto> bannerData;

  HomeDataDto({required this.userData, required this.bannerData});

  factory HomeDataDto.fromJson(Map<String, dynamic> json) {
    return HomeDataDto(
      userData: UserDataDTO.fromJson(json['data']),
      bannerData: (json['data']['banners'] as List)
          .map((e) => BannerDataDto.fromJson(e))
          .toList(),
    );
  }
}
