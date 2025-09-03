import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/features/balance/presentation/page/balance_page.dart';
import 'package:telephone_recharge_application/features/devices/presentation/cubit/connect_to_ble_device_cubit.dart';
import 'package:telephone_recharge_application/features/devices/presentation/cubit/get_ble_devices_cubit.dart';
import 'package:telephone_recharge_application/features/devices/presentation/pages/device_page.dart';
import 'package:telephone_recharge_application/features/initilize/presentation/pages/card_mode_list_page.dart';
import 'package:telephone_recharge_application/features/initilize/presentation/pages/restricted_mode_initilization_page.dart';
import 'package:telephone_recharge_application/features/mode/presentation/page/change_mode_page.dart';
import 'package:telephone_recharge_application/features/options/presentation/pages/options_page.dart';
import 'package:telephone_recharge_application/features/recharge/presentation/page/recharge_page.dart';
import 'package:telephone_recharge_application/features/recharge_history/presentation/page/recharge_history_page.dart';
import 'package:telephone_recharge_application/init_dependencies.dart';
import '../../features/authentication/login/presentation/pages/login_page.dart';

class GeneratedRoutes {
  static Route? onGenerate(RouteSettings settings) {
    const String login = "/login";
    const String devices = "/devices";
    const String options = "/options";
    const String rechargeHistory = "/rechargeHistory";
    const String balance = "/balance";
    const String recharge = "/recharge";
    const String changeMode = "/changeMode";
    const String cardModeListPage = "/cardModeListPage";
    const String restrictedModeInitilizationPage =
        "/restrictedModeInitilizationPage";
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case devices:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => serviceLocator<GetBleDevicesCubit>(),
              ),
              BlocProvider(
                create: (context) => serviceLocator<ConnectToBleDeviceCubit>(),
              ),
            ],
            child: DevicePage(),
          ),
        );
      case options:
        return MaterialPageRoute(builder: (context) => OptionsPage());
      case rechargeHistory:
        return MaterialPageRoute(builder: (context) => RechargeHistoryPage());
      case balance:
        return MaterialPageRoute(builder: (context) => BalancePage());
      case recharge:
        return MaterialPageRoute(builder: (context) => RechargePage());
      case changeMode:
        return MaterialPageRoute(builder: (context) => ChangeModePage());
      case cardModeListPage:
        return MaterialPageRoute(builder: (context) => CardModeListPage());
      case restrictedModeInitilizationPage:
        return MaterialPageRoute(
          builder: (context) => RestrictedModeInitilizationPage(),
        );
      default:
        return null;
    }
  }
}
