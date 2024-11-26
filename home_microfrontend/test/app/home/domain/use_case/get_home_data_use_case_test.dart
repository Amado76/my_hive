import 'package:flutter_test/flutter_test.dart';
import 'package:home_microfrontend/app/home/data/dto/banner_data_dto.dart';
import 'package:home_microfrontend/app/home/data/dto/home_data_dto.dart';
import 'package:home_microfrontend/app/home/data/dto/user_data_dto.dart';
import 'package:home_microfrontend/app/home/domain/entity/banner_entity.dart';
import 'package:home_microfrontend/app/home/domain/use_case/get_home_data_use_case.dart';
import 'package:home_microfrontend/app/home/domain/repository/home_repository_interface.dart';
import 'package:home_microfrontend/app/home/domain/entity/user_entity.dart';
import 'package:mocktail/mocktail.dart';

class HomeRepositoryMock extends Mock implements HomeRepositoryInterface {}

void main() {
  late HomeRepositoryMock homeRepositoryMock;
  late GetHomeDataUseCase getHomeDataUseCase;
  setUp(() {
    homeRepositoryMock = HomeRepositoryMock();
    getHomeDataUseCase = GetHomeDataUseCase(homeRepositoryMock);
  });
  test('should return a UserEntity and BannerEntity', () {
    when(() => homeRepositoryMock.getHomeData())
        .thenAnswer((_) async => homeDataDto);
    getHomeDataUseCase().then((value) {
      expect(value.userEntity, isA<UserEntity>());
      expect(value.bannerEntityList, isA<List<BannerEntity>>());
    });
  });
}

final HomeDataDto homeDataDto = HomeDataDto(
    userData: UserDataDTO(
      userAvatarPath: 'teste',
    ),
    bannerData: [
      BannerDataDto(
          imageUrl: 'teste',
          action: 'teste',
          actionUrl: 'teste',
          moduleRoute: 'teste'),
      BannerDataDto(
          imageUrl: 'teste2',
          action: 'teste2',
          actionUrl: 'teste2',
          moduleRoute: 'teste2')
    ]);
