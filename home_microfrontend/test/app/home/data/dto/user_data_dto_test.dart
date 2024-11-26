import 'package:flutter_test/flutter_test.dart';
import 'package:home_microfrontend/app/home/data/dto/user_data_dto.dart';

void main() {
  test('should create a  [UserDataDTO] from a json', () {
    //
    final UserDataDTO userDataDTO = UserDataDTO.fromJson(json['data']);
    // assert
    expect(userDataDTO.userAvatarPath, 'https://teste.com.br');
  });

  test('should return a map when use .toMap', () {
    final UserDataDTO userDataDTO = UserDataDTO.fromJson(json['data']);

    final Map<String, dynamic> map = userDataDTO.toMap();

    expect(map['userAvatarPath'], "https://teste.com.br");
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
      }
    ]
  }
};
