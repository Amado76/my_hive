import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/util/http_client/interceptors/status_error_interceptor.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

class StatusErrorInterceptorMock extends Mock
    implements StatusErrorInterceptor {}

void main() {
  final dioMock = DioMock();
  final HttpClientInterface httpClientAdapter = DioAdapter(dio: dioMock);

  group('[get]', () {
    test('should return {"data":"data"} and status code 200', () async {
      //Arrange

      when(() => dioMock.get(any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'))).thenAnswer((_) async => dioResponse);
      //Act
      final result = await httpClientAdapter.get(path: 'path');
      //Assert
      expect(result.data, {'data': 'data'});
      expect(result.statusCode, 200);
    });
  });

  group('[put]', () {
    test('should return {"data": "data"} and status code 200', () async {
      //Arrange
      when(() => dioMock.put(any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'))).thenAnswer((_) async => dioResponse);
      //Act
      final result = await httpClientAdapter.put(
          path: 'path',
          headers: {'authToken': 'authToken', 'userId': 'userId'},
          data: {});
      //Assert
      expect(result.data, {'data': 'data'});
      expect(result.statusCode, 200);
    });
  });

  group('[delete]', () {
    test('should return {"data": "data"} and status code 200', () async {
      //Arrange
      when(() => dioMock.delete(any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'))).thenAnswer((_) async => dioResponse);
      //Act
      final result = await httpClientAdapter.delete(
          path: 'path',
          headers: {'authToken': 'authToken', 'userId': 'userId'},
          data: {});
      //Assert
      expect(result.data, {'data': 'data'});
      expect(result.statusCode, 200);
    });
  });
  group('[post]', () {
    test('should return {"data": "data"} and status code 200', () async {
      //Arrange
      when(() => dioMock.post(any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'))).thenAnswer((_) async => dioResponse);
      //Act
      final result = await httpClientAdapter.post(
          path: 'path',
          headers: {'authToken': 'authToken', 'userId': 'userId'},
          data: {});
      //Assert
      expect(result.data, {'data': 'data'});
      expect(result.statusCode, 200);
    });
  });

  group('[DioAdapter]', () {
    test('should add interceptors to Dio', () {
      //Arrange
      final statusErrorInterceptorMock = StatusErrorInterceptorMock();
      final dioAdapter =
          DioAdapter(dio: Dio(), interceptors: [statusErrorInterceptorMock]);

      //Assert
      expect(dioAdapter.interceptorList, contains(statusErrorInterceptorMock));
    });
  });
}

Response dioResponse = Response(
    data: {'data': 'data'},
    statusCode: 200,
    requestOptions: RequestOptions(path: 'path'));
