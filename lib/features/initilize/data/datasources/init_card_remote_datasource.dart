import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/utils/telephone_bluetooth_manager.dart';
import 'package:telephone_recharge_application/features/initilize/data/models/init_card_restricted_model.dart';

abstract interface class InitCardRemoteDatasource {
  Future<bool> checkInternetConnection();
  Future<bool> writeRestrictedModeToCard({
    required String serviceUuid,
    required String charactristicUuid,
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
  Future<String> deductAmountFromDatabase() async {
    try {
      return "";
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> writeRestrictedModeToCard({
    required String serviceUuid,
    required String charactristicUuid,
    required InitCardRestrictedModel cardDetails,
  }) async {
    try {
      final service = await bluetoothManager.getTargetService(
        Guid.fromString(serviceUuid),
      );
      final jsonResponse = await bluetoothManager.writeJsonAndWaitForResponse(
        service: service,
        charUuid: Guid(charactristicUuid),
        payload: cardDetails.toJson(),
      );
      if (jsonResponse == null) {
        throw LocalException(message: "no response from device");
      }
      if (jsonResponse["error_status"] == "1") {
        throw LocalException(message: "error while writing");
      }
      return true;
    } on LocalException catch (e) {
      throw LocalException(message: e.message);
    } catch (_) {
      throw LocalException(message: "error occured in the process try again");
    }
  }

  @override
  Future<bool> checkInternetConnection() async {
    return await connection.hasInternetAccess;
  }
}
