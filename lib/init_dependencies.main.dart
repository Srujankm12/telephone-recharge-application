part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  await _initHive();
  await _initHttp();
  _initBluetoothManager();
  await _requestBlePermissions();
  await _initInternetConnectivity();
  _initAuth();
  _initCardBalance();
  _initRechargeHistory();
  _initDevicesListCubit();
  _initCardMode();
}

Future<void> _initHive() async {
  final hiveDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(hiveDir.path);
  final Box<String> box = await Hive.openBox("credentials");
  serviceLocator.registerLazySingleton(() => box);
}

Future<void> _requestBlePermissions() async {
  if (await Permission.bluetoothScan.isDenied) {
    await Permission.bluetoothScan.request();
  }
  if (await Permission.bluetoothConnect.isDenied) {
    await Permission.bluetoothConnect.request();
  }
  if (await Permission.location.isDenied) {
    await Permission.location.request();
  }
}

void _initBluetoothManager() {
  final TelephoneBluetoothManager bluetoothManager =
      TelephoneBluetoothManager();
  serviceLocator.registerLazySingleton(() => bluetoothManager);
}

Future<void> _initHttp() async {
  final http.Client client = http.Client();
  serviceLocator.registerLazySingleton(() => client);
}

Future<void> _initInternetConnectivity() async {
  final InternetConnection connection = InternetConnection();
  serviceLocator.registerLazySingleton(() => connection);
}

void _initAuth() async {
  serviceLocator
    ..registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(client: serviceLocator()),
    )
    ..registerLazySingleton<AuthLocalDatasource>(
      () => AuthLocalDatasourceImpl(box: serviceLocator()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDatasource: serviceLocator(),
        authLocalDatasource: serviceLocator(),
      ),
    )
    ..registerLazySingleton<LoginUsecase>(
      () => LoginUsecase(authRepository: serviceLocator()),
    )
    ..registerLazySingleton<AutoLoginUsecase>(
      () => AutoLoginUsecase(authRepository: serviceLocator()),
    )
    ..registerFactory<LoginCubit>(
      () => LoginCubit(loginUsecase: serviceLocator()),
    )
    ..registerFactory<AutoLoginCubit>(
      () => AutoLoginCubit(autoLoginUsecase: serviceLocator()),
    );
}

void _initCardBalance() {
  serviceLocator
    ..registerLazySingleton<BalanceLocalDatasource>(
      () => BalanceLocalDatasourceImpl(bluetoothManager: serviceLocator()),
    )
    ..registerLazySingleton<BalanceRepository>(
      () => BalanceRepositoryImpl(balanceLocalDatasource: serviceLocator()),
    )
    ..registerLazySingleton<GetBalanceUsecase>(
      () => GetBalanceUsecase(balanceRepository: serviceLocator()),
    )
    ..registerFactory<GetBalanceCubit>(
      () => GetBalanceCubit(getBalanceUsecase: serviceLocator()),
    );
}

void _initRechargeHistory() {
  serviceLocator
    ..registerLazySingleton<RechargeHistoryRemoteDatasource>(
      () => RechargeHistoryRemoteDatasourceImpl(client: serviceLocator()),
    )
    ..registerLazySingleton<RechargeHistoryLocalDatasource>(
      () => RechargeHistoryLocalDatasourceImpl(
        box: serviceLocator(),
        connection: serviceLocator(),
      ),
    )
    ..registerLazySingleton<RechargeHistoryRepository>(
      () => RechargeHistoryRepositoryImpl(
        rechargeHistoryLocalDatasource: serviceLocator(),
        rechargeHistoryRemoteDatasource: serviceLocator(),
      ),
    )
    ..registerLazySingleton<GetRechargeHistoryUsecase>(
      () => GetRechargeHistoryUsecase(
        rechargeHistoryRepository: serviceLocator(),
      ),
    )
    ..registerFactory<GetRechargeHistoryCubit>(
      () => GetRechargeHistoryCubit(rechargeHistoryUsecase: serviceLocator()),
    );
}

void _initDevicesListCubit() async {
  serviceLocator
    ..registerLazySingleton<DevicesLocalDatasource>(
      () => DevicesLocalDatasourceImpl(bluetoothManager: serviceLocator()),
    )
    ..registerLazySingleton<DevicesRepository>(
      () => DevicesRepositoryImpl(devicesLocalDatasource: serviceLocator()),
    )
    ..registerLazySingleton<GetBleDevicesUsecase>(
      () => GetBleDevicesUsecase(devicesRepository: serviceLocator()),
    )
    ..registerLazySingleton<ConnectToBleDeviceUsecase>(
      () => ConnectToBleDeviceUsecase(devicesRepository: serviceLocator()),
    )
    ..registerFactory<GetBleDevicesCubit>(
      () => GetBleDevicesCubit(getBleDevicesUsecase: serviceLocator()),
    )
    ..registerFactory<ConnectToBleDeviceCubit>(
      () =>
          ConnectToBleDeviceCubit(connectToBleDeviceUsecase: serviceLocator()),
    );
}

void _initCardMode() async {
  serviceLocator
    ..registerLazySingleton<InitCardLocalDatasource>(
      () => InitCardLocalDatasourceImpl(
        bluetoothManager: serviceLocator(),
        box: serviceLocator(),
      ),
    )
    ..registerLazySingleton<InitCardRemoteDatasource>(
      () => InitCardRemoteDatasourceImpl(
        client: serviceLocator(),
        connection: serviceLocator(),
      ),
    )
    ..registerLazySingleton<InitCardRepository>(
      () => InitCardRepositoryImpl(
        initCardLocalDatasource: serviceLocator(),
        initCardRemoteDatasource: serviceLocator(),
      ),
    )
    ..registerLazySingleton<InitCardRestrictedUsecase>(
      () => InitCardRestrictedUsecase(initCardRepository: serviceLocator()),
    )
    ..registerFactory<InitCardRestrictedCubit>(
      () =>
          InitCardRestrictedCubit(initCardRestrictedUsecase: serviceLocator()),
    );
}
