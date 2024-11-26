import 'package:common_microfrontend/util/theme_and_colors/data/theme_dto.dart';
import 'package:common_microfrontend/util/theme_and_colors/domain/interfaces/theme_repository_interface.dart';

class ChangeThemeUsecase {
  final ThemeRepositoryInterface _themeRepository;

  ChangeThemeUsecase({
    required ThemeRepositoryInterface themeRepository,
  }) : _themeRepository = themeRepository;

  Future<ThemeDto?> call() async {
    return await _themeRepository.getTheme();
  }
}
