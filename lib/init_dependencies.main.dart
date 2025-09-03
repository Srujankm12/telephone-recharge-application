part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  await _initHive();
  await _initHttp();
  await _requestBlePermissions();
  await _initInternetConnectivity();
  _initBluetoothManager();
  await _initDevicesListCubit();
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

Future<void> _initDevicesListCubit() async {
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
