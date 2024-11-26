import 'package:common_microfrontend/modules/user/data/dtos/module_auth_drawer_dto.dart';
import 'package:common_microfrontend/modules/user/data/dtos/module_auth_home_dto.dart';
import 'package:common_microfrontend/modules/user/domain/entities/module_auth_drawer_entity.dart';
import 'package:common_microfrontend/modules/user/domain/entities/module_auth_home_entity.dart';
import 'package:common_microfrontend/modules/user/domain/repositories/module_auth_repository_interface.dart';
import 'package:common_microfrontend/util/http_client/http_client_adapter.dart';
import 'package:common_microfrontend/util/url_injector/url_injector.dart';

class ModuleAuthRepositoryImpl implements ModuleAuthRepositoryInterface {
  final HttpClientInterface _httpClient;
  final UrlInjector _urlInjector;

  ModuleAuthRepositoryImpl({
    required HttpClientInterface httpClient,
    required UrlInjector urlInjector,
  })  : _httpClient = httpClient,
        _urlInjector = urlInjector;

  @override
  Future<List<ModuleAuthDrawerEntity>> getModuleAuthDrawer() async {
    final response = await getResponse();

    List<dynamic> moduleAuthDrawerMaps = response.data['data']['modules'];

    List<ModuleAuthDrawerDTO> moduleAuthDrawerDTOList =
        ModuleAuthDrawerDTO.fromMapList(moduleAuthDrawerMaps);

    List<ModuleAuthDrawerEntity> moduleAuthDrawerEntityList =
        moduleAuthDrawerDTOList
            .map<ModuleAuthDrawerEntity>(
              (moduleAuthDrawerDTO) =>
                  ModuleAuthDrawerEntity.fromDTO(moduleAuthDrawerDTO),
            )
            .toList();

    return moduleAuthDrawerEntityList;
  }

  @override
  Future<List<ModuleAuthHomeEntity>> getModuleAuthHome() async {
    final response = await getResponse();

    List<dynamic> moduleAuthHomeMaps = response.data['data']['home'];

    List<ModuleAuthHomeDTO> moduleAuthHomeDTOList =
        ModuleAuthHomeDTO.fromMapList(moduleAuthHomeMaps);

    List<ModuleAuthHomeEntity> moduleAuthHomeEntityList = moduleAuthHomeDTOList
        .map<ModuleAuthHomeEntity>(
          (moduleAuthHomeDTO) =>
              ModuleAuthHomeEntity.fromDTO(moduleAuthHomeDTO),
        )
        .toList();

    return moduleAuthHomeEntityList;
  }

  getResponse() async {
    final String url = _urlInjector.getEndPoint(
      endpoint: 'get_modules_auth',
      package: 'user_common',
    );
    final response = await _httpClient.get(path: url);
    return response;
  }
}
