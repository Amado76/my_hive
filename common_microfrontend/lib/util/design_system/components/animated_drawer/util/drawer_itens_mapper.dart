import 'package:common_microfrontend/common_microfrontend.dart';
import 'package:flutter/material.dart';

class DrawerItensMapper {
  final NavigationInjector navigator = Modular.get<NavigationInjector>();

  String getPath(String route) {
    switch (route) {
      case 'Home':
        return navigator.getPath(
          package: 'baseapp',
          pathKey: 'home',
        );
      case 'Communication':
        return navigator.getPath(
          package: 'baseapp',
          pathKey: 'notification',
        );
      default:
        return navigator.getPath(
          package: 'baseapp',
          pathKey: 'home',
        );
    }
  }

  IconData getIconData(String iconLib, String iconName) {
    switch (iconLib) {
      case 'AntDesign':
        switch (iconName) {
          case 'home':
            return Icons.home;
          case 'user':
            return Icons.person;
          case 'calendar':
            return Icons.calendar_month;
          default:
            return Icons.error;
        }
      case 'Entypo':
        switch (iconName) {
          case 'browser':
            return Entypo.browser;
          case 'shop':
            return Entypo.shop;
          default:
            return Icons.error;
        }
      case 'Feather':
        switch (iconName) {
          case 'youtube':
            return Feather.youtube;
          case 'tv':
            return Feather.tv;
          case 'users':
            return Icons.person;
          default:
            return Icons.error;
        }
      case 'FontAwesome':
        switch (iconName) {
          case 'soccer-ball-o':
            return FontAwesome.soccer_ball_o;
          case 'whatsapp':
            return FontAwesome.whatsapp;
          default:
            return Icons.error;
        }
      case 'Ionicons':
        switch (iconName) {
          case 'school-outline':
            return Ionicons.school_outline;
          default:
            return Icons.error;
        }
      case 'MaterialCommunityIcons':
        switch (iconName) {
          case 'message-outline':
            return MaterialCommunityIcons.message_outline;
          case 'gamepad-variant-outline':
            return MaterialCommunityIcons.gamepad_variant_outline;
          case 'trophy-outline':
            return MaterialCommunityIcons.trophy_outline;
          case 'file-document-outline':
            return MaterialCommunityIcons.file_document_outline;
          default:
            return Icons.error;
        }
      default:
        return Icons.error;
    }
  }
}
