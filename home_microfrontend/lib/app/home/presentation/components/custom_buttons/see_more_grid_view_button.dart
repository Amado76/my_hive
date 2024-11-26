import 'package:common_microfrontend/util/design_system/components/animated_drawer/presentation/drawer_controller_data.dart';
import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class SeeMoreGridViewButton extends StatelessWidget {
  const SeeMoreGridViewButton({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final DrawerControllerData? drawerData = DrawerControllerData.of(context);
    final AnimationController? animationController =
        drawerData?.animationController;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          if (animationController!.isAnimating) {
            return;
          }

          if (animationController.isCompleted) {
            animationController.reverse();
          } else {
            animationController.forward();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 50,
              color: primaryColor,
            ),
            Text(
                Modular.get<Translation>()
                    .translate(key: "seeMore", package: "home"),
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
