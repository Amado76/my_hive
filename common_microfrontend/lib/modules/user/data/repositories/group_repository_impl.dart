import 'package:common_microfrontend/modules/user/data/dtos/group_dto.dart';
import 'package:common_microfrontend/modules/user/domain/entities/group_entity.dart';
import 'package:common_microfrontend/modules/user/domain/repositories/group_repository_interface.dart';
import 'package:common_microfrontend/util/http_client/http_client_adapter.dart';
import 'package:common_microfrontend/util/url_injector/url_injector.dart';

class GroupRepositoryImpl implements GroupRepositoryInterface {
  final HttpClientInterface _httpClient;
  final UrlInjector _urlInjector;

  GroupRepositoryImpl({
    required HttpClientInterface httpClient,
    required UrlInjector urlInjector,
  })  : _httpClient = httpClient,
        _urlInjector = urlInjector;

  @override
  Future<List<GroupEntity>> getGroup() async {
    final String url = _urlInjector.getEndPoint(
      endpoint: 'get_profiles',
      package: 'user_common',
    );
    final response = await _httpClient.get(path: url);
    List<dynamic> groupMaps = response.data['data']['groups'];

    List<GroupDTO> groupDTOList = GroupDTO.fromMapList(groupMaps);

    List<GroupEntity> groupEntityList = groupDTOList
        .map<GroupEntity>(
          (groupDTO) => GroupEntity.fromDTO(groupDTO),
        )
        .toList();

    return groupEntityList;
  }
}
