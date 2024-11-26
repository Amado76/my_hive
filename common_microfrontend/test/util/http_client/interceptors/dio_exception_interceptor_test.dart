import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:common_microfrontend/util/http_client/interceptors/dio_exception_interceptor.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class DioExceptionMock extends Mock implements DioException {}

class ErrorInterceptorHandlerMock extends Mock
    implements ErrorInterceptorHandler {}

void main() {
  group('DioErrorInterceptor Tests', () {
    late DioExceptionInterceptor interceptor;
    late DioException dioException;
    late ErrorInterceptorHandlerMock handler;

    setUp(() {
      interceptor = DioExceptionInterceptor();
      dioException = DioExceptionMock();
      handler = ErrorInterceptorHandlerMock();
    });

    test('should throw CustomConnectionException when DioException occurs', () {
      when(() => dioException.requestOptions)
          .thenReturn(RequestOptions(path: 'https://test.com'));

      when(() => dioException.response).thenReturn(
        Response(
          requestOptions: RequestOptions(path: 'https://test.com'),
          statusCode: 400,
          data: {
            'non_field_errors': [
              'Impossível fazer login com as credenciais fornecidas.'
            ],
          },
        ),
      );

      expect(
          () => interceptor.onError(dioException, handler),
          throwsA(predicate((e) =>
              e is CustomConnectionException &&
              e.toString().contains(
                  'Impossível fazer login com as credenciais fornecidas.'))));
    });
  });
}
