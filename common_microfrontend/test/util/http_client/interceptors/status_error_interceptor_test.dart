import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:common_microfrontend/util/http_client/interceptors/status_error_interceptor.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockResponse extends Mock implements Response {}

class MockResponseInterceptorHandler extends Mock
    implements ResponseInterceptorHandler {}

void main() {
  group('StatusErrorInterceptor Tests', () {
    // Instancia o interceptor
    final interceptor = StatusErrorInterceptor();

    test('should skip processing if skipStatusErrorInterceptor is true', () {
      // Cria um mock da Response e do handler
      final response = MockResponse();
      final handler = MockResponseInterceptorHandler();

      // Configura o mock da Response para simular skipInterceptor true
      when(() => response.extra)
          .thenReturn({'skipStatusErrorInterceptor': true});

      // Verifica se o handler.next é chamado
      interceptor.onResponse(response, handler);
      verify(() => handler.next(response)).called(1);
    });

    test('should proceed normally if status is not 0', () {
      // Cria um mock da Response e do handler
      final response = MockResponse();
      final handler = MockResponseInterceptorHandler();

      // Configura o mock da Response para simular status 1
      when(() => response.data).thenReturn({'status': 1});
      when(() => response.extra).thenReturn({});

      // Verifica se o handler.next é chamado
      interceptor.onResponse(response, handler);
      verify(() => handler.next(response)).called(1);
    });

    test('should throw GTecException if status is 0', () {
      // Cria um mock da Response e do handler
      final response = MockResponse();
      final handler = MockResponseInterceptorHandler();

      // Configura o mock da Response para simular status 0
      when(() => response.data)
          .thenReturn({'status': "0", 'msg': 'Error message'});
      when(() => response.extra).thenReturn({});

      // Espera que uma exceção seja lançada
      expect(
          () => interceptor.onResponse(response, handler),
          throwsA(predicate(
              (e) => e is GTecException && e.message == 'Error message')));
    });
  });
}
