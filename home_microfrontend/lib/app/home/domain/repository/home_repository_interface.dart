import 'package:home_microfrontend/app/home/data/dto/home_data_dto.dart';

abstract class HomeRepositoryInterface {
  Future<HomeDataDto> getHomeData();
  Future<bool> hasCommunicationNotifications();
}
