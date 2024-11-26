import 'package:flutter/material.dart';

class DrawerControllerData extends InheritedWidget {
  final AnimationController animationController;
  final Animation<double> toggleAnimation;

  const DrawerControllerData({
    super.key,
    required this.animationController,
    required this.toggleAnimation,
    required super.child,
  });

  static DrawerControllerData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DrawerControllerData>();
  }

  @override
  bool updateShouldNotify(DrawerControllerData oldWidget) {
    return animationController != oldWidget.animationController ||
        toggleAnimation != oldWidget.toggleAnimation;
  }
}
