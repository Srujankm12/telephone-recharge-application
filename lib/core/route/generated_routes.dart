import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/features/devices/presentation/pages/device_page.dart';
import 'package:telephone_recharge_application/features/options/presentation/pages/options_page.dart';
import '../../features/authentication/login/presentation/pages/login_page.dart';

class GeneratedRoutes {
  static Route? onGenerate(RouteSettings settings) {
    const String login = "/login";
    const String devices = "/devices";
    const String options = "/options";
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case devices:
        return MaterialPageRoute(builder: (context) => DevicePage());
      case options:
        return MaterialPageRoute(builder: (context) => OptionsPage());
      default:
        return null;
    }
  }
}
