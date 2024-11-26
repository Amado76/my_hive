import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:common_microfrontend/util/theme_and_colors/data/theme_dto.dart';
import 'package:common_microfrontend/util/theme_and_colors/domain/interfaces/theme_repository_interface.dart';

class ThemeRepositoryImp implements ThemeRepositoryInterface {
  final HttpClientInterface _httpClientAdapter;
  final UrlInjector _urlInjector;

  ThemeRepositoryImp({
    required HttpClientInterface httpClientAdapter,
    required UrlInjector urlInjector,
  })  : _httpClientAdapter = httpClientAdapter,
        _urlInjector = urlInjector;

  @override
  Future<ThemeDto?> getTheme() async {
    final String url = _urlInjector.getEndPoint(
      endpoint: 'current_theme',
      package: 'theme_and_colors',
    );
    try {
      final response = await _httpClientAdapter.get(
        path: url,
      );

      var data = response.data['data'];
      return ThemeDto.fromJson(data);
    } catch (e) {
      return null;
    }
  }
}
