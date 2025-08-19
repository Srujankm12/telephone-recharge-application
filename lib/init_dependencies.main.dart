part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  await _initHive();
  await _initHttp();
  await _requestBlePermissions();
  _initFlutterBluePlus();
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

void _initFlutterBluePlus() {
  final FlutterBluePlus bluetooth = FlutterBluePlus();
  serviceLocator.registerLazySingleton(() => bluetooth);
}

Future<void> _initHttp() async {
  final http.Client client = http.Client();
  serviceLocator.registerLazySingleton(() => client);
}
