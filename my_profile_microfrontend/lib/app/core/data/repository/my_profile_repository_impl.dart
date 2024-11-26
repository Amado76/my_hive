import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:my_profile_microfrontend/app/core/domain/dto/profile_dto.dart';
import 'package:my_profile_microfrontend/app/core/domain/entities/my_profile_entity.dart';
import 'package:my_profile_microfrontend/app/core/domain/repository/my_profile_repository_interface.dart';

class MyProfileRepositoryImpl implements MyProfileRepositoryInterface {
  final HttpClientInterface _httpClient;
  final UrlInjector _urlInjector;

  MyProfileRepositoryImpl({
    required HttpClientInterface httpClient,
    required UrlInjector urlInjector,
  })  : _httpClient = httpClient,
        _urlInjector = urlInjector;

  @override
  Future<MyProfileEntity> getProfile() async {
    final url = _urlInjector.getEndPoint(
        endpoint: 'readProfile', package: 'my_profile');
    final response = await _httpClient.get(path: url);

    return MyProfileEntity.fromJson(response.data['data']);
  }

  @override
  Future<void> updateProfile(ProfileDto updateDto, int? studentId) async {
    final Map<String, dynamic> updateData = updateDto.toJson();
    updateData['student_id'] = studentId;
    final url = _urlInjector.getEndPoint(
        endpoint: 'updateProfile', package: 'my_profile');

    await _httpClient.post(path: url, data: updateData);
  }
}
