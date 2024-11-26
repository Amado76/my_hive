import 'package:flutter/material.dart';
import 'package:home_microfrontend/app/home/domain/entity/module_data_entity.dart';
import 'package:home_microfrontend/app/home/domain/module_data_strategy.dart';
import 'package:home_microfrontend/app/home/presentation/bloc/home_bloc.dart';
import 'package:home_microfrontend/app/home/presentation/components/animation/notification_animation.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class CommunicationButton extends StatelessWidget {
  const CommunicationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ModuleDataEntity? moduleData =
        CommunicationModuleDataStrategy().moduleData("Communication");
    final String pathIcon = moduleData?.pathIcon ?? "assets/icons/person.png";
    final String textIcon = moduleData?.moduleName ?? "";
    final HomeBloc homeBloc = Modular.get<HomeBloc>();
    final bool hasCommunicationNotifications =
        homeBloc.state.hasCommunicationNotifications;
    final NavigationInjector navigationInjector =
        Modular.get<NavigationInjector>();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Modular.to.pushNamed(navigationInjector.getPath(
              package: moduleData!.package, pathKey: moduleData.pathKey));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                moduleData == null
                    ? const SizedBox(
                        height: 40,
                      )
                    : SizedBox(
                        height: 40,
                        child: Image.asset(
                          fit: BoxFit.cover,
                          pathIcon,
                          package: "home_microfrontend",
                        ),
                      ),
                Visibility(
                  visible: hasCommunicationNotifications,
                  child: const Positioned(
                    top: -5,
                    right: 0,
                    child: SizedBox(
                      width: 17.5,
                      height: 17.5,
                      child: NotificationAnimation(),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Text(textIcon,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
