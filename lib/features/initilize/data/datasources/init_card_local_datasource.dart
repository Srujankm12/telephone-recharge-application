import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:telephone_recharge_application/core/constants/bluetooth_constants.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/utils/telephone_bluetooth_manager.dart';
import 'package:telephone_recharge_application/features/initilize/data/models/init_card_free_to_dial_model.dart';
import 'package:telephone_recharge_application/features/initilize/data/models/init_card_restricted_model.dart';
import 'package:http/http.dart' as http;

abstract interface class InitCardLocalDatasource {
  Future<bool> initRestrictedMode({
    required InitCardRestrictedModel restrictedModeDetails,
  });
  Future<bool> initFreeToDialMode({
    required InitCardFreeToDialModel freeToDialModeDetails,
  });
}

class InitCardLocalDatasourceImpl implements InitCardLocalDatasource {
  final TelephoneBluetoothManager bluetoothManager;
  final http.Client client;
  InitCardLocalDatasourceImpl({
    required this.bluetoothManager,
    required this.client,
  });
  @override
  Future<bool> initRestrictedMode({
    required InitCardRestrictedModel restrictedModeDetails,
  }) async {
    try {
      final service = await bluetoothManager.getTargetService(
        Guid(BluetoothConstants.serviceUuid),
      );
      final response = await bluetoothManager.writeJsonAndWaitForResponse(
        service: service,
        charUuid: Guid(BluetoothConstants.charUuid),
        payload: restrictedModeDetails.toJson(),
      );
      if (response!["error_status"] == "0") {
        return true;
      }
      return false;
    } catch (_) {
      throw LocalException(message: "Error while Initilizing.");
    }
  }

  @override
  Future<bool> initFreeToDialMode({
    required InitCardFreeToDialModel freeToDialModeDetails,
  }) async {
    try {
      final service = await bluetoothManager.getTargetService(
        Guid(BluetoothConstants.serviceUuid),
      );
      final response = await bluetoothManager.writeJsonAndWaitForResponse(
        service: service,
        charUuid: Guid(BluetoothConstants.charUuid),
        payload: freeToDialModeDetails.toJson(),
      );
      if (response!["error_status"] == "0") {
        return true;
      }
      return false;
    } catch (e) {}
  }
}
