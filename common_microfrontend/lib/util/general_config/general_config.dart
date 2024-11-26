import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/widgets.dart';
import 'package:common_microfrontend/modules/user/domain/entities/user_entity.dart';
import 'package:common_microfrontend/modules/user/domain/usecases/generate_user_entity_use_case.dart';

class GeneralConfig {
  String? _business;
  String? _buildBusiness;
  String? _language;
  AuthUserEntity? _authUserEntity;
  UserEntity? _userEntity;
  final AuthUserRepositoryInterface? _authUserRepo;
  final GenerateUserEntityUseCase _generateUserEntityUseCase;
  final ThemeAndColorsBloc _themeAndColorsBloc;

  GeneralConfig({
    required AuthUserRepositoryInterface authUserRepo,
    required GenerateUserEntityUseCase generateUserEntityUseCase,
    required ThemeAndColorsBloc themeAndColorsBloc,
  })  : _authUserRepo = authUserRepo,
        _generateUserEntityUseCase = generateUserEntityUseCase,
        _themeAndColorsBloc = themeAndColorsBloc {
    authUserRepo.authTokenStream.listen(
      (AuthUserEntity authUserEntity) {
        _authUserEntity = authUserEntity;
      },
    );

    generateUserEntityUseCase.userEntityStream.listen(
      (UserEntity userEntity) {
        _userEntity = userEntity;
      },
    );
  }

  //setters
  set business(String? value) {
    if (_business != null) {
      throw GTecException(
        message: "Business is already initialized.",
      );
    }
    _business = value;
  }

  set buildBusiness(String? value) {
    if (_buildBusiness != null) {
      throw GTecException(
        message: "Build Business is already initialized.",
      );
    }
    _buildBusiness = value;
  }

  set language(String? value) {
    _language = value;
  }

  //getters
  String? get business {
    if (_business == null) {
      throw GTecException(
        message:
            "Business not initialized. Call business before accessing instance.",
      );
    }
    return _business;
  }

  String? get buildBusiness {
    if (_buildBusiness == null) {
      throw GTecException(
        message:
            "Build Business not initialized. Call business before accessing instance.",
      );
    }
    return _buildBusiness;
  }

  AuthUserEntity? get authUserEntity => _authUserEntity;
  UserEntity? get userEntity => _userEntity;
  AuthUserRepositoryInterface? get authUserRepo => _authUserRepo;

  String? get language {
    if (_language == null) {
      throw GTecException(
        message:
            "Language not initialized. Call language before accessing instance.",
      );
    }
    return _language;
  }

  //Token e UserEntity são stream que são atualizados automaticamente. Não
  //precisam ser chamados manualmente.
  Future<void> init() async {
    try {
      await configAuthToken();
      await generateUserEntity();
      _themeAndColorsBloc.changeTheme();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> configAuthToken() async {
    _authUserEntity = await _authUserRepo?.retrieve();
  }

  Future<void> generateUserEntity() async {
    _userEntity = await _generateUserEntityUseCase();
  }

  @visibleForTesting
  void reset() {
    _business = null;
    _buildBusiness = null;
    _language = null;
  }
}
