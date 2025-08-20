import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:telephone_recharge_application/core/utils/telephone_bluetooth_manager.dart';
import 'package:telephone_recharge_application/features/initilize/data/models/init_card_restricted_model.dart';

abstract interface class InitCardRemoteDatasource {
  Future<bool> checkInternetConnection();
  Future<String> writeRestrictedModeToCard({
    required String service,
    required String charactristic,
    required InitCardRestrictedModel cardDetails,
  });
  Future<String> deductAmountFromDatabase();
}

class InitCardRemoteDatasourceImpl implements InitCardRemoteDatasource {
  final TelephoneBluetoothManager bluetoothManager;
  final http.Client client;
  final InternetConnection connection;
  InitCardRemoteDatasourceImpl({
    required this.bluetoothManager,
    required this.client,
    required this.connection,
  });
  @override
  Future<String> deductAmountFromDatabase() async {}

  @override
  Future<String> writeRestrictedModeToCard({
    required String serviceUuid,
    required String charactristicUuid,
    required InitCardRestrictedModel cardDetails,
  }) async {
    final service = await bluetoothManager.getTargetService(Guid.fromString(serviceUuid));
    await bluetoothManager.writeToDevice(service, Guid.fromString(charactristicUuid), cardDetails);
  }

  @override
  Future<bool> checkInternetConnection() async {
    return await connection.hasInternetAccess;
  }
}
