import 'package:flutter/widgets.dart';

class DrawerItem {
  final String name;
  final IconData icon;
  final String? route;

  const DrawerItem(
    this.name,
    this.icon,
    this.route,
  );
}
