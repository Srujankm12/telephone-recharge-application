part of 'generated_routes_import.dart';

class GeneratedRoutes {
  static Route? onGenerate(RouteSettings settings) {
    const String landing = "/landing";
    const String login = "/login";
    const String forgotPassword = "/forgotPassword";
    const String forgotPasswordOtp = "/forgotPasswordOtp";
    const String devices = "/devices";
    const String options = "/options";
    const String history = "/history";
    const String balance = "/balance";
    const String recharge = "/recharge";
    const String changeMode = "/changeMode";
    const String cardModeList = "/cardModeListPage";
    const String initRestricted = "/InitRestricted";
    const String initFreeToDial = "/InitFreeToDial";
    const String addPhoneNumbers = "/addPhoneNumbers";
    const String changePhoneNumbers = "/changePhoneNumbers";

    final args = settings.arguments;
    switch (settings.name) {
      case landing:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => serviceLocator<AutoLoginCubit>(),
            child: LandingPage(),
          ),
        );
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
      case history:
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
      case cardModeList:
        if (args is OptionsPageArgs) {
          return MaterialPageRoute(
            builder: (context) => CardModeListPage(args: args),
          );
        }
      case initRestricted:
        if (args is OptionsPageArgs) {
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => serviceLocator<InitCardRestrictedCubit>(),
              child: RestrictedModeInitilizationPage(args: args),
            ),
          );
        }
      case initFreeToDial:
        if (args is OptionsPageArgs) {
          return MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) => serviceLocator<InitCardFreeToDialCubit>(),
                child: FreeToDialModeInitilizationPage(args: args),
              );
            },
          );
        }
      case addPhoneNumbers:
        return MaterialPageRoute(builder: (context) => AddPhoneNumberPage());
      case changePhoneNumbers:
        return MaterialPageRoute(builder: (context) => ChangePhoneNumberPage());
      default:
        return null;
    }
    return null;
  }
}
