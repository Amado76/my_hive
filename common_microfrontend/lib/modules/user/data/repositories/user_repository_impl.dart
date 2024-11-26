import 'package:common_microfrontend/util/http_client/http_client_adapter.dart';
import 'package:common_microfrontend/util/url_injector/url_injector.dart';
import 'package:flutter/foundation.dart';
import 'package:common_microfrontend/modules/user/data/dtos/user_me_dto.dart';
import 'package:common_microfrontend/modules/user/data/dtos/user_profile_dto.dart';
import 'package:common_microfrontend/modules/user/domain/entities/user_entity.dart';
import 'package:common_microfrontend/modules/user/domain/repositories/user_repository_interface.dart';

class UserRepositoryImpl implements UserRepositoryInterface {
  final HttpClientInterface _httpClient;
  final UrlInjector _urlInjector;

  UserRepositoryImpl({
    required HttpClientInterface httpClient,
    required UrlInjector urlInjector,
  })  : _httpClient = httpClient,
        _urlInjector = urlInjector;

  @override
  Future<UserEntity> getUser() async {
    List<UserEntity> results = await Future.wait([
      _getUserMe(),
      _getUserProfile(),
    ]);

    final UserEntity userEntity = UserEntity.combine(results[0], results[1]);
    return userEntity;
  }

  Future<UserEntity> _getUserMe() async {
    final String url = _urlInjector.getEndPoint(
      endpoint: 'get_me',
      package: 'user_common',
    );
    final response = await _httpClient.get(path: url);
    final userDTO = UserMeDTO.fromMap(response.data['data']);
    UserEntity userEntity = UserEntity.fromUserMeDTO(userDTO);
    return userEntity;
  }

  Future<UserEntity> _getUserProfile() async {
    final String url = _urlInjector.getEndPoint(
      endpoint: 'get_current_profile',
      package: 'user_common',
    );
    final response = await _httpClient.get(path: url);
    final userDTO = UserProfileDTO.fromMap(response.data['data']);
    UserEntity userEntity = UserEntity.fromUserProfileDTO(userDTO);
    return userEntity;
  }

  @visibleForTesting
  Future<UserEntity> getUserProfileForTesting() async {
    return _getUserProfile();
  }

  @visibleForTesting
  Future<UserEntity> getUserMeForTesting() async {
    return _getUserMe();
  }
}
