import 'package:home_microfrontend/app/home/domain/repository/home_repository_interface.dart';

class HasCommunicationNotificationsUseCase {
  final HomeRepositoryInterface _homeRepository;

  HasCommunicationNotificationsUseCase(this._homeRepository);

  Future<bool> call() async {
    bool hasCommunicationNotificaions =
        await _homeRepository.hasCommunicationNotifications();

    return hasCommunicationNotificaions;
  }
}
