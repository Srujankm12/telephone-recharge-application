import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/core/arguments/options_page_args.dart';
import 'package:telephone_recharge_application/features/authentication/forgot_password/presentation/pages/forgot_password_otp_page.dart';
import 'package:telephone_recharge_application/features/authentication/forgot_password/presentation/pages/forgot_password_page.dart';
import 'package:telephone_recharge_application/features/authentication/login/presentation/cubit/auto_login_cubit.dart';
import 'package:telephone_recharge_application/features/authentication/login/presentation/cubit/login_cubit.dart';
import 'package:telephone_recharge_application/features/balance/presentation/cubit/get_balance_cubit.dart';
import 'package:telephone_recharge_application/features/balance/presentation/page/balance_page.dart';
import 'package:telephone_recharge_application/features/devices/presentation/cubit/connect_to_ble_device_cubit.dart';
import 'package:telephone_recharge_application/features/devices/presentation/cubit/get_ble_devices_cubit.dart';
import 'package:telephone_recharge_application/features/devices/presentation/pages/device_page.dart';
import 'package:telephone_recharge_application/features/initilize/presentation/cubit/init_card_restricted_cubit.dart';
import 'package:telephone_recharge_application/features/initilize/presentation/pages/card_mode_list_page.dart';
import 'package:telephone_recharge_application/features/initilize/presentation/pages/free_to_dial_mode_initilization_page.dart';
import 'package:telephone_recharge_application/features/initilize/presentation/pages/restricted_mode_initilization_page.dart';
import 'package:telephone_recharge_application/features/mode/presentation/page/change_mode_page.dart';
import 'package:telephone_recharge_application/features/options/presentation/pages/options_page.dart';
import 'package:telephone_recharge_application/features/recharge/presentation/page/recharge_page.dart';
import 'package:telephone_recharge_application/features/recharge_history/presentation/cubit/get_recharge_history_cubit.dart';
import 'package:telephone_recharge_application/features/recharge_history/presentation/page/recharge_history_page.dart';
import 'package:telephone_recharge_application/init_dependencies.dart';
import '../../features/authentication/login/presentation/pages/login_page.dart';

class GeneratedRoutes {
  static Route? onGenerate(RouteSettings settings) {
    const String login = "/login";
    const String forgotPassword = "/forgotPassword";
    const String forgotPasswordOtp = "/forgotPasswordOtp";
    const String devices = "/devices";
    const String options = "/options";
    const String rechargeHistory = "/rechargeHistory";
    const String balance = "/balance";
    const String recharge = "/recharge";
    const String changeMode = "/changeMode";
    const String cardModeListPage = "/cardModeListPage";
    const String restrictedModeInitilizationPage =
        "/restrictedModeInitilizationPage";
    const String freeToDialModeInitilizationPage =
        "/freeToDialModeInitilizationPage";

    final args = settings.arguments;
    switch (settings.name) {
      // Login Page
      case login:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => serviceLocator<LoginCubit>()),
              BlocProvider(
                create: (context) => serviceLocator<AutoLoginCubit>(),
              ),
            ],
            child: LoginPage(),
          ),
        );
      // Forgot Password Email Page
      case forgotPassword:
        return MaterialPageRoute(builder: (context) => ForgotPasswordPage());
      // Forgot Password OTP Verification Page
      case forgotPasswordOtp:
        return MaterialPageRoute(builder: (context) => ForgotPasswordOtpPage());
      // Device Page Route
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
      // Options Page Route
      case options:
        if (args is OptionsPageArgs) {
          return MaterialPageRoute(
            builder: (context) => OptionsPage(args: args),
          );
        }
      // Recharge History Page Route
      case rechargeHistory:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => serviceLocator<GetRechargeHistoryCubit>(),
            child: RechargeHistoryPage(),
          ),
        );
      case balance:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => serviceLocator<GetBalanceCubit>(),
            child: BalancePage(),
          ),
        );
      case recharge:
        return MaterialPageRoute(builder: (context) => RechargePage());
      case changeMode:
        return MaterialPageRoute(builder: (context) => ChangeModePage());
      case cardModeListPage:
        if (args is OptionsPageArgs) {
          return MaterialPageRoute(
            builder: (context) => CardModeListPage(args: args),
          );
        }
      case restrictedModeInitilizationPage:
        if (args is OptionsPageArgs) {
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => serviceLocator<InitCardRestrictedCubit>(),
              child: RestrictedModeInitilizationPage(args: args),
            ),
          );
        }
      case freeToDialModeInitilizationPage:
        if (args is OptionsPageArgs) {
          return MaterialPageRoute(
            builder: (context) {
              return FreeToDialModeInitilizationPage(args: args);
            },
          );
        }
      default:
        return null;
    }
    return null;
  }
}
