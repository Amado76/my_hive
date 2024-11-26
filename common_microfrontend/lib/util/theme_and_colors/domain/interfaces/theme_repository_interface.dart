import 'package:common_microfrontend/util/theme_and_colors/data/theme_dto.dart';

abstract class ThemeRepositoryInterface {
  Future<ThemeDto?> getTheme();
}
