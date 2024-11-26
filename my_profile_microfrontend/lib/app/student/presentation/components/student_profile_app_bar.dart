import 'package:flutter/material.dart';
import 'package:common_microfrontend/common_microfrontend.dart';

class StudentProfileAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Translation translation = Modular.get<Translation>();

  StudentProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final gradientStyle =
        Theme.of(context).extension<GradienteColorsExtension>();

    return AppBar(
      title: Text(
        translation.translate(package: 'my_profile', key: 'pageTitle'),
        style: TextStyle(
          color: Theme.of(context).appBarTheme.titleTextStyle?.color ??
              Colors.white,
        ),
      ),
      bottom: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorColor: Theme.of(context).primaryColor,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(
            child: TabTitle(translation.translate(
                package: 'my_profile', key: 'personalData')),
          ),
          Tab(
            child: TabTitle(translation.translate(
                package: 'my_profile', key: 'accessData')),
          ),
          Tab(
            child: TabTitle(
                translation.translate(package: 'my_profile', key: 'address')),
          ),
          Tab(
            child: TabTitle(
                translation.translate(package: 'my_profile', key: 'documents')),
          ),
        ],
      ),
      leading: const IconDrawerButtonToggle(),
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
  Size get preferredSize =>
      const Size.fromHeight(kTextTabBarHeight + kToolbarHeight);
}

class TabTitle extends StatelessWidget {
  const TabTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Text(
      title,
      style: TextStyle(
        color: theme.appBarTheme.titleTextStyle?.color ?? Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
