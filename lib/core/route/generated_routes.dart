import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/features/balance/presentation/page/balance_page.dart';
import 'package:telephone_recharge_application/features/devices/presentation/pages/device_page.dart';
import 'package:telephone_recharge_application/features/options/presentation/pages/options_page.dart';
import 'package:telephone_recharge_application/features/recharge/presentation/page/recharge_page.dart';
import 'package:telephone_recharge_application/features/recharge_history/presentation/page/recharge_history_page.dart';
import '../../features/authentication/login/presentation/pages/login_page.dart';

class GeneratedRoutes {
  static Route? onGenerate(RouteSettings settings) {
    const String login = "/login";
    const String devices = "/devices";
    const String options = "/options";
    const String rechargeHistory = "/rechargeHistory";
    const String balance = "/balance";
    const String recharge = "/recharge";
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case devices:
        return MaterialPageRoute(builder: (context) => DevicePage());
      case options:
        return MaterialPageRoute(builder: (context) => OptionsPage());
      case rechargeHistory:
        return MaterialPageRoute(builder: (context) => RechargeHistoryPage());
      case balance:
        return MaterialPageRoute(builder: (context) => BalancePage());
      case recharge:
        return MaterialPageRoute(builder: (context) => RechargePage());
      default:
        return null;
    }
  }
}
