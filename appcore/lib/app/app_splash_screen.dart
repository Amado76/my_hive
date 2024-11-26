import 'package:flutter/material.dart';

class AppSplashScreen extends StatefulWidget {
  final Color background;

  const AppSplashScreen({super.key, required this.background});

  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  double _opacity = 0;
  double _scale = 1;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _opacity = 1;
        _scale = 1.3;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: widget.background,
      child: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 2),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 1, end: _scale),
            duration: const Duration(seconds: 2),
            builder: (BuildContext context, double scale, Widget? child) {
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: Image.asset(
              'assets/images/logo.png',
              width: 150,
            ),
          ),
        ),
      ),
    );
  }
}
