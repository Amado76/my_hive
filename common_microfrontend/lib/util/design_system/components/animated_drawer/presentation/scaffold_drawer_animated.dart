import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'drawer_controller_data.dart';
import 'drawer_data.dart';

class ScaffoldDrawerAnimated extends StatefulWidget {
  final Widget child;

  const ScaffoldDrawerAnimated({
    super.key,
    required this.child,
  });

  @override
  ScaffoldDrawerAnimatedState createState() => ScaffoldDrawerAnimatedState();
}

class ScaffoldDrawerAnimatedState extends State<ScaffoldDrawerAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      _controller,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final rightSlidePage = screenWidth * 0.6;
    final rightSlideDrawer = -screenWidth;
    const radius = 20.0;

    return DrawerControllerData(
      animationController: _controller,
      toggleAnimation: _animation,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          double slide = rightSlidePage * _controller.value;
          double slideDrawer = rightSlideDrawer * (1 - _controller.value);
          double scale = 1 - (_controller.value * 0.3);
          double radiusScreen = radius * _controller.value;
          return Stack(
            children: [
              Transform(
                transform: Matrix4.identity()..translate(slideDrawer),
                child: Scaffold(
                  // backgroundColor: Colors.white,
                  body: Modular.get<DrawerData>(),
                ),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.all(Radius.circular(radiusScreen)),
                        child: widget.child,
                      ),
                    ),
                    Visibility(
                      visible: _controller.value == 1.0,
                      child: GestureDetector(
                        onTap: () {
                          if (_controller.isAnimating) {
                            return;
                          }

                          if (_controller.isCompleted) {
                            _controller.reverse();
                          } else {
                            _controller.forward();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
