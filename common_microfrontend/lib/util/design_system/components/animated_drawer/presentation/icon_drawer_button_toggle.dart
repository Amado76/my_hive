import 'package:flutter/material.dart';
import 'package:common_microfrontend/util/theme_and_colors/domain/util/hex_color.dart';
import 'drawer_controller_data.dart';

class IconDrawerButtonToggle extends StatelessWidget {
  const IconDrawerButtonToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final DrawerControllerData? drawerData = DrawerControllerData.of(context);
    final AnimationController? animationController =
        drawerData?.animationController;
    final Animation<double>? toggleAnimation = drawerData?.toggleAnimation;

    return IconButton(
      icon: AnimatedIcon(
        color: Color(HexColor.intFromHex('#b27d00')),
        icon: AnimatedIcons.menu_close,
        progress: toggleAnimation!,
      ),
      onPressed: () {
        if (animationController!.isAnimating) {
          return;
        }

        if (animationController.isCompleted) {
          animationController.reverse();
        } else {
          animationController.forward();
        }
      },
    );
  }
}
