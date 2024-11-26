import 'package:appcore/app/dto/app_core_config_dto.dart';
import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/material.dart';

// Essa classe foi necessária devido ao Modular obrigar um root "/" para a navegação
// ignore: must_be_immutable
class AppPageRedirect extends StatefulWidget {
  final AppCoreConfigDto appCoreConfigDto;
  AppPageRedirect({
    super.key,
    required this.appCoreConfigDto,
  }) {
    if (appCoreConfigDto.homeUrl == null) {
      final NavigationInjector navigatorPath =
          Modular.get<NavigationInjector>();
      appCoreConfigDto.homeUrl = navigatorPath.getPath(
        package: 'baseapp',
        pathKey: 'home',
      );
    }
  }

  @override
  State<AppPageRedirect> createState() => _AppPageState();
}

class _AppPageState extends State<AppPageRedirect>
    with SingleTickerProviderStateMixin {
  final NavigationInjector navigatorPath = Modular.get<NavigationInjector>();
  final GeneralConfig gc = Modular.get<GeneralConfig>();
  final ThemeAndColorsBloc themeAndColorsBloc =
      Modular.get<ThemeAndColorsBloc>();

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Suaviza a transição
      ),
    )..addListener(() {
        setState(() {});
      });

    WidgetsBinding.instance.addPostFrameCallback((_) => _asyncMethod());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _asyncMethod() async {
    try {
      if (widget.appCoreConfigDto.tokenToExample != null) {
        final saveUserTokenUseCase = Modular.get<SaveUserTokenUseCase>();
        await saveUserTokenUseCase(widget.appCoreConfigDto.tokenToExample!);
      }
      await gc.init();

      themeAndColorsBloc.changeTheme(
          themeMode: widget.appCoreConfigDto.themeMode);
      Future.delayed(const Duration(seconds: 2));
      Modular.to.navigate(
        widget.appCoreConfigDto.homeUrl!,
        arguments: widget.appCoreConfigDto.args,
      );
    } catch (e) {
      themeAndColorsBloc.changeTheme(
          themeMode: widget.appCoreConfigDto.themeMode);
      if (e is CustomConnectionException && e.statusCode == 401 ||
          gc.authUserEntity?.accessToken == null) {
        Modular.to.navigate(
          navigatorPath.getPath(
            package: 'baseapp',
            pathKey: 'authentication',
          ),
        );
        return;
      } else {
        rethrow;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.appCoreConfigDto.background,
      child: Center(
        child: AnimatedOpacity(
          opacity: _animation.value,
          duration: const Duration(milliseconds: 500),
          child: Image.asset(
            'assets/images/logo.png',
            width: 150 * 1.22,
          ),
        ),
      ),
    );
  }
}
