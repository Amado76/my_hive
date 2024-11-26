import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[NavigationInjector Tests]', () {
    test('should correctly set the path', () {
      //Arrange
      Modular.bindModule(NavigationInjectorModular());

      final NavigationInjector navigator = Modular.get<NavigationInjector>();
      navigator.reset();
      //Act
      navigator.setPaths(package: 'teste', pathList: {
        'login': '/login',
        'logout': '/logout',
        'home': '/home',
      });
      //Assert
      expect(
          navigator.getPath(
            package: 'teste',
            pathKey: 'login',
          ),
          '/login');
      expect(
          navigator.getPath(
            package: 'teste',
            pathKey: 'logout',
          ),
          '/logout');
      expect(
          navigator.getRelativePath(
            package: 'teste',
            pathKey: 'home',
          ),
          './home');
      expect(
          navigator.getRelativePath(
            package: 'teste',
            pathKey: 'login',
          ),
          './login');
      expect(
          navigator.getRelativePath(
            package: 'teste',
            pathKey: 'logout',
          ),
          './logout');
      expect(
          navigator.getRelativePath(
            package: 'teste',
            pathKey: 'home',
          ),
          './home');
    });

    test('should throw an exception if the path is already set', () {
      //Arrange
      Modular.bindModule(NavigationInjectorModular());

      final NavigationInjector navigator = Modular.get<NavigationInjector>();
      navigator.reset();
      //Act
      navigator.setPaths(
        package: 'teste',
        pathList: {
          'login': '/login',
        },
      );
      //Assert
      expect(
          () => navigator.setPaths(
                package: 'teste',
                pathList: {
                  'login2': '/login',
                },
              ),
          throwsA(isA<GTecException>().having(
            (e) => e.message,
            'Conferir message',
            equals('Path value "/login" already set in package "teste".'),
          )));
    });
    test('should throw an exception if the key is already set', () {
      //Arrange
      Modular.bindModule(NavigationInjectorModular());

      final NavigationInjector navigator = Modular.get<NavigationInjector>();
      navigator.reset();
      //Act
      navigator.setPaths(
        package: 'teste',
        pathList: {
          'login': '/login',
        },
      );
      //Assert
      expect(
          () => navigator.setPaths(
                package: 'teste',
                pathList: {
                  'login': '/login2',
                },
              ),
          throwsA(isA<GTecException>().having(
            (e) => e.message,
            'Conferir message',
            equals('Path key "login" already set in package "teste".'),
          )));
    });
    test('should throw an exception if trying to retrieve a non-existent path',
        () {
      //Arrange
      final NavigationInjector navigator = Modular.get<NavigationInjector>();
      navigator.reset();
      //Act
      navigator.setPaths(
        package: 'teste',
        pathList: {
          'login': '/login',
          'logout': '/logout',
          'home': '/home',
        },
      );
      //Assert
      expect(
          () => navigator.getPath(
                package: 'teste',
                pathKey: 'home2',
              ),
          throwsException);
    });
    test(
        'should throw an exception if trying to retrieve a non-existent relativePath',
        () {
      //Arrange
      Modular.bindModule(NavigationInjectorModular());

      final NavigationInjector navigator = Modular.get<NavigationInjector>();
      navigator.reset();
      //Act
      navigator.setPaths(
        package: 'teste',
        pathList: {
          'login': '/login',
          'logout': '/logout',
          'home': '/home',
        },
      );
      //Assert
      expect(
          () => navigator.getRelativePath(
                package: 'teste',
                pathKey: 'home2',
              ),
          throwsException);
    });
  });

  test('should throw an exception if trying to retrieve a non-existent path',
      () {
    //Arrange
    Modular.bindModule(NavigationInjectorModular());
    final NavigationInjector navigator = Modular.get<NavigationInjector>();
    navigator.reset();
    //Act
    navigator.setPaths(
      package: 'teste',
      pathList: {
        'login': '/login',
        'logout': '/logout',
        'home': '/home',
      },
    );
    //Assert
    expect(
        () => navigator.getPathInPackage(
              package: 'teste',
              pathKey: 'home2',
            ),
        throwsA(isA<GTecException>()));
  });

  test('should return a path when call fetPathInPackage', () {
    //Arrange
    Modular.bindModule(NavigationInjectorModular());
    final NavigationInjector navigator = Modular.get<NavigationInjector>();
    navigator.reset();
    //Act
    navigator.setPaths(
      package: 'teste',
      pathList: {
        'login': '/login',
        'logout': '/logout',
        'home': '/home',
      },
    );
    //Assert
    expect(
        navigator.getPathInPackage(
          package: 'teste',
          pathKey: 'home',
        ),
        '/teste/home');
  });
}

class NavigationInjectorModular extends Module {
  @override
  List<Module> get imports => [
        CommonModule(),
      ];
}
