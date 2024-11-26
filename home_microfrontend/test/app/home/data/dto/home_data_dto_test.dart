import 'package:flutter_test/flutter_test.dart';
import 'package:home_microfrontend/app/home/data/dto/banner_data_dto.dart';
import 'package:home_microfrontend/app/home/data/dto/home_data_dto.dart';

void main() {
  test('should create a [HomeDataDTO] from a Json', () {
    final HomeDataDto homeDataDto = HomeDataDto.fromJson(json);

    expect(homeDataDto.bannerData, isA<List<BannerDataDto>>());
  });
}

final Map<String, dynamic> json = {
  "status": "1",
  "msg": "",
  "details": "",
  "data": {
    "user_avatar": "https://teste.com.br",
    "community_logo": false,
    "banners": [
      {
        "url_image": "https://teste.com.br",
        "action": "page",
        "url": null,
        "id": 1379,
        "module": "home"
      },
      {
        "url_image": "https://teste.com.br",
        "action": "link",
        "url": "https://teste.com.br",
        "id": 1377,
        "area": null
      },
      {
        "url_image": "https://teste.com.br",
        "action": "link",
        "url": "https://en.wikipedia.org/",
        "id": 1378,
        "area": null
      },
      {
        "url_image": "https://teste.com.br",
        "action": "page",
        "url": null,
        "id": 1380,
        "module": "home"
      }
    ]
  }
};
