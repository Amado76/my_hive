import 'package:flutter/material.dart';

class NotificationAnimation extends StatefulWidget {
  const NotificationAnimation({super.key});

  @override
  State<NotificationAnimation> createState() => _NotificationAnimationState();
}

class _NotificationAnimationState extends State<NotificationAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  List<double> listRadius = [7.0, 10.5, 14, 17.5];
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 0.5,
    );

    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
        children: listRadius
            .map((radius) => Container(
                  width: radius * _animationController.value,
                  height: radius * _animationController.value,
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .primaryColor
                          .withOpacity(1.0 - _animationController.value),
                      borderRadius: BorderRadius.circular(10)),
                ))
            .toList());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
