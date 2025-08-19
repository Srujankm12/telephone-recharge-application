part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  await _initHive();
  await _initHttp();
  _initFlutterBluePlus();
}

Future<void> _initHive() async {
  final hiveDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(hiveDir.path);
  final Box<String> box = await Hive.openBox("credentials");
  serviceLocator.registerLazySingleton(() => box);
}

void _initFlutterBluePlus() {
  final FlutterBluePlus bluetooth = FlutterBluePlus();
  serviceLocator.registerLazySingleton(() => bluetooth);
}

Future<void> _initHttp() async {
  final http.Client client = http.Client();
  serviceLocator.registerLazySingleton(() => client);
}
