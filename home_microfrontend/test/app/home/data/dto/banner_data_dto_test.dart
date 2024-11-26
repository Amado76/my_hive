import 'package:flutter_test/flutter_test.dart';
import 'package:home_microfrontend/app/home/data/dto/banner_data_dto.dart';

void main() {
  test('should create a [BannerDataDTO] from a Json when area is null', () {
    final BannerDataDto bannerData =
        BannerDataDto.fromJson(json['data']['banners'][0]);

    expect(
      bannerData.imageUrl,
      "https://teste.com.br",
    );
    expect(bannerData.action, "link");
    expect(
      bannerData.actionUrl,
      "https://teste.com.br",
    );
    expect(bannerData.moduleRoute, null);
  });

  test('should create a [BannerDataDTO] from a Json when area is not null', () {
    final BannerDataDto bannerData =
        BannerDataDto.fromJson(json['data']['banners'][1]);

    expect(
      bannerData.imageUrl,
      "https://teste.com.br",
    );
    expect(bannerData.action, "link");
    expect(
      bannerData.actionUrl,
      "https://teste.com.br",
    );
    expect(bannerData.moduleRoute, 'teste');
  });

  test('should return a map when use .toMap', () {
    final BannerDataDto bannerData =
        BannerDataDto.fromJson(json['data']['banners'][1]);

    final Map<String, dynamic> map = bannerData.toMap();

    expect(map['imageUrl'], "https://teste.com.br");
    expect(map['action'], "link");
    expect(
      map['actionUrl'],
      "https://teste.com.br",
    );
    expect(map['moduleRoute'], 'teste');
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
        "action": "link",
        "url": "https://teste.com.br",
        "area": null
      },
      {
        "url_image": "https://teste.com.br",
        "action": "link",
        "url": "https://teste.com.br",
        "area": 'teste'
      }
    ]
  }
};
