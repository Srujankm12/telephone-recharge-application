import 'package:flutter/material.dart';
import '../../features/authentication/login/presentation/pages/login_page.dart';

class GeneratedRoutes {
  static Route? onGenerate(RouteSettings settings) {
    const String login = "/login";
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (context) => LoginPage());
      default:
        return null;
    }
  }
}