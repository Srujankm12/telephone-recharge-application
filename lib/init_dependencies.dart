import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:telephone_recharge_application/core/utils/telephone_bluetooth_manager.dart';
import 'package:telephone_recharge_application/features/devices/data/datasources/devices_local_datasource.dart';
import 'package:telephone_recharge_application/features/devices/data/repository/devices_repository_impl.dart';
import 'package:telephone_recharge_application/features/devices/domain/repository/devices_repository.dart';
import 'package:telephone_recharge_application/features/devices/domain/usecases/get_ble_devices_usecase.dart';
import 'package:telephone_recharge_application/features/devices/presentation/cubit/get_ble_devices_cubit.dart';

part 'init_dependencies.main.dart';