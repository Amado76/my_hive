import 'package:flutter_test/flutter_test.dart';
import 'package:common_microfrontend/util/url_injector/url_injector.dart';
import 'package:common_microfrontend/util/url_injector/url_injector_object.dart';

void main() {
  group('[URLInjector Tests]', () {
    test('should correctly set the base URL', () {
      //Arrange
      final urlInjector = UrlInjector.instance;
      //Act
      urlInjector.setBaseUrl(url: 'http://localhost:3000');
      //Assert
      expect(urlInjector.getBaseUrl(), 'http://localhost:3000');
    });

    test('should correctl set registerUrl', () {
      //Arrange
      final urlInjector = UrlInjector.instance;
      UrlInjector.reset();
      //Act
      urlInjector.setBaseUrl(url: 'http://localhost:3000');
      urlInjector.registerUrl(UrlObjectTest());
      //Assert
      expect(urlInjector.getEndPoint(endpoint: 'login', package: 'login'),
          'http://localhost:3000/login');
    });

    test('should throw an exception if the base URL is already set', () {
      //Arrange
      final urlInjector = UrlInjector.instance;
      UrlInjector.reset();

      //Act
      urlInjector.setBaseUrl(url: 'http://localhost:3000');
      //Assert
      expect(() => urlInjector.setBaseUrl(url: 'http://localhost:3000'),
          throwsException);
    });

    test(
        'should throw an exception if trying to retrieve a non-existent endpoint',
        () {
      //Arrange
      final urlInjector = UrlInjector.instance;
      UrlInjector.reset();
      urlInjector.setBaseUrl(url: 'http://localhost:3000');
      //Act
      //Assert
      expect(
          () => urlInjector.getEndPoint(
              endpoint: 'notFound', package: 'notFound'),
          throwsException);
    });
    test(
        'should throw an exception if trying to get an endpoint when the base URL is not set',
        () {
      //Arrange
      final urlInjector = UrlInjector.instance;
      UrlInjector.reset();
      urlInjector.setEndpoints(endpointsList: addExistingEndpoint);
      //Act

      //Assert
      expect(() => urlInjector.getEndPoint(endpoint: 'login', package: 'login'),
          throwsException);
    });
    // test(
    //     'should throw an exception when trying to add an endpoint that already exists',
    //     () {
    //   //Arrange
    //   final urlInjector = UrlInjector.instance;
    //   UrlInjector.reset();
    //   //Act
    //   urlInjector.setEndpoints(endpointsList: endpoints);
    //   //Assert
    //   expect(() => urlInjector.setEndpoints(endpointsList: addExistingEndpoint),
    //       throwsException);
    // });
    test('should generate a key correctly', () {
      //Arrange
      final urlInjector = UrlInjector.instance;
      //Act
      final key = urlInjector.generateKey(
          package: 'package', endpointIdentifier: 'oldKey');
      //Assert
      expect(key, 'package-oldKey');
    });
  });
}

Map<String, String> endpoints = {
  'login': '/login',
  'register': '/register',
  'logout': '/logout',
  'user': '/user',
};

Map<String, String> addnewEndpoint = {
  'addnew': '/addnew',
};

Map<String, String> addExistingEndpoint = {
  'login': '/login',
  'register': '/register',
  'logout': '/logout',
  'user': '/user'
};

class UrlObjectTest extends UrlInjectorObject {
  @override
  List<Map<String, dynamic>> get mapData => [
        {
          'package': 'login',
          'endpointIdentifier': 'login',
          'endpoint': '/login',
        },
        {
          'package': 'register',
          'endpointIdentifier': 'register',
          'endpoint': '/register',
        }
      ];
}
