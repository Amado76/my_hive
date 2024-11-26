import 'package:flutter_test/flutter_test.dart';
import 'package:home_microfrontend/app/home/domain/repository/home_repository_interface.dart';
import 'package:home_microfrontend/app/home/domain/use_case/has_communication_notifications_use_case.dart';
import 'package:mocktail/mocktail.dart';

class HomeRepositoryMock extends Mock implements HomeRepositoryInterface {}

void main() {
  late HomeRepositoryMock homeRepositoryMock;
  late HasCommunicationNotificationsUseCase
      hasCommunicationNotificationsUseCase;
  setUp(() {
    homeRepositoryMock = HomeRepositoryMock();
    hasCommunicationNotificationsUseCase =
        HasCommunicationNotificationsUseCase(homeRepositoryMock);
  });

  test('should return a bool', () {
    when(() => homeRepositoryMock.hasCommunicationNotifications())
        .thenAnswer((_) async => true);
    hasCommunicationNotificationsUseCase().then((value) {
      expect(value, isA<bool>());
    });
  });
}
