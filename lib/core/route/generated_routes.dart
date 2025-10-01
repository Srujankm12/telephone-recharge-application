part of 'generated_routes_import.dart';

class GeneratedRoutes {
  static Route? onGenerate(RouteSettings settings) {
    const String landing = "/landing";
    const String login = "/login";
    const String devices = "/devices";
    const String options = "/options";
    const String history = "/history";
    const String balance = "/balance";
    const String recharge = "/recharge";
    const String changeMode = "/changeMode";
    const String initCardMode = "/initCardMode";
    const String addPhoneNumbers = "/addPhoneNumbers";
    const String changePhoneNumbers = "/changePhoneNumbers";
    const String phoneNumberOptions = "/phoneNumberOptions";

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
      case initCardMode:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => serviceLocator<InitCardCubit>(),
            child: InitCardPage(),
          ),
        );
      case recharge:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => serviceLocator<RechargeCubit>(),
            child: RechargePage(),
          ),
        );
      case changeMode:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => serviceLocator<GetCardModeCubit>(),
              ),
              BlocProvider(
                create: (context) => serviceLocator<ChangeCardModeCubit>(),
              ),
            ],
            child: ChangeModePage(),
          ),
        );
      case changePhoneNumbers:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => serviceLocator<AddPhoneNumbersCubit>(),
              ),
              BlocProvider(
                create: (context) => serviceLocator<GetPhoneNumberCubit>(),
              ),
            ],
            child: ChangePhoneNumberPage(),
          ),
        );
      case addPhoneNumbers:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => serviceLocator<AddPhoneNumbersCubit>(),
            child: InitPhoneNumberPage(),
          ),
        );
      case phoneNumberOptions:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => serviceLocator<CheckCardModeCubit>(),
            child: PhoneNumberOptionsPage(),
          ),
        );
      default:
        return null;
    }
    return null;
  }
}
