import 'package:common_microfrontend/modules/user/domain/usecases/delete_user_token_use_case.dart';
import 'package:common_microfrontend/modules/user/domain/usecases/get_current_profile_use_case.dart';
import 'package:common_microfrontend/util/navigation_injector/navigation_injector.dart';
import 'package:common_microfrontend/util/translation/domain/entity/translation.dart';
import 'package:flutter/material.dart';

import 'package:common_microfrontend/util/design_system/components/animated_drawer/domain/use_case/get_drawer_filtered_use_case.dart';
import 'package:common_microfrontend/util/theme_and_colors/presentation/widgets/theme_mode_color_extension.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../domain/entities/drawer_item.dart';
import 'drawer_controller_data.dart';

class DrawerData extends StatelessWidget {
  final Translation translation;
  final NavigationInjector navigator;
  final DeleteUserTokenUseCase logoutUseCase;
  final GetCurrentProfileUseCase getCurrentProfile;
  final GetDrawerFilteredUseCase getDrawerFilteredUseCase;

  const DrawerData(
      {super.key,
      required this.translation,
      required this.navigator,
      required this.logoutUseCase,
      required this.getCurrentProfile,
      required this.getDrawerFilteredUseCase});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final String? logoUrl = getCurrentProfile().logoUrl;
    final themeMode = Theme.of(context).extension<ThemeModeColorExtension>();

    List<DrawerItem> drawer = getDrawerFilteredUseCase();

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: screenWidth * 0.6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  logoUrl ?? '',
                  width: 130,
                  errorBuilder: (_, __, ___) {
                    return Image.asset(
                      'assets/images/logo.png',
                      width: 130,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: drawer.length,
                // shrinkWrap: true,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12, left: 12),
                    child: InkWell(
                      onTap: () async {
                        await navigateTo(context, drawer[index].route!);
                      },
                      child: SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                drawer[index].icon,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                drawer[index].name,
                                style: const TextStyle(fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
          const Divider(
            color: Colors.white54,
          ),
          Row(
            children: [
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    Modular.to.navigate(
                      navigator.getPath(
                        package: 'baseapp',
                        pathKey: 'settings',
                      ),
                    );
                  },
                  child: Icon(
                    Icons.settings,
                    color: themeMode?.textColor ?? Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () async {
                    await logoutUseCase();
                    Modular.to.navigate(
                      navigator.getPath(
                        package: 'baseapp',
                        pathKey: 'authentication',
                      ),
                    );
                  },
                  child: Icon(
                    Icons.logout,
                    color: themeMode?.textColor ?? Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> navigateTo(BuildContext context, String route) async {
    final drawerData = DrawerControllerData.of(context);
    final animationController = drawerData?.animationController;
    if (animationController!.isCompleted) {
      await animationController.reverse();
      Modular.to.navigate(route);
      // });
    }
  }
}
