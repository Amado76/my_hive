import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class SingleFeedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Translation translation = Modular.get<Translation>();

  SingleFeedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final gradientStyle =
        Theme.of(context).extension<GradienteColorsExtension>();

    return AppBar(
      title: Text(
        translation.translate(package: 'feed', key: 'pageTitle'),
        style: const TextStyle(color: Colors.white),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          Modular.to.pop();
        },
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              gradientStyle?.secondaryColor ?? const Color(0xFF00264E),
              gradientStyle?.primaryColor ?? const Color(0xFF004E86)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
