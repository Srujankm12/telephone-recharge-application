import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:telephone_recharge_application/core/constants/bluetooth_constants.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/utils/telephone_bluetooth_manager.dart';

abstract interface class ModeLocalDatasource {
  Future<String> checkCardMode({required String signal});
  Future<String> changeCardMode({required String signal, required String mode});
}

class ModeLocalDatasourceImpl implements ModeLocalDatasource {
  final TelephoneBluetoothManager bluetoothManager;
  ModeLocalDatasourceImpl({required this.bluetoothManager});
  @override
  Future<String> changeCardMode({
    required String signal,
    required String mode,
  }) async {
    try {
      if (!await bluetoothManager.checkBluetoothState()) {
        throw LocalException(message: "Bluetooth is Turned OFF.");
      }
      if (!await bluetoothManager.isConnected()) {
        throw LocalException(message: "Disconnected from Device.");
      }
      final service = await bluetoothManager.getTargetService(
        Guid(BluetoothConstants.serviceUuid),
      );
      final response = await bluetoothManager.writeJsonAndWaitForResponse(
        service: service,
        charUuid: Guid(BluetoothConstants.charUuid),
        payload: {"signal": signal, "mode": mode},
      );
      if (response == null) {
        throw LocalException(message: "No Response from Device.");
      }
      if (response["error_status"] == "1") {
        throw LocalException(message: "Card Not Found.");
      }
      if (response["error_status"] == "2") {
        throw LocalException(message: "Card Authentication Failed.");
      }
      if (response["error_status"] == "3") {
        throw LocalException(message: "Card Write Failed.");
      }
      return response["mode"];
    } on LocalException catch (e) {
      throw LocalException(message: e.message);
    } catch (_) {
      throw LocalException(message: "Exception in BLE.");
    }
  }

  @override
  Future<String> checkCardMode({required String signal}) async {
    try {
      if (!await bluetoothManager.checkBluetoothState()) {
        throw LocalException(message: "Bluetooth is Turned OFF.");
      }
      if (!await bluetoothManager.isConnected()) {
        throw LocalException(message: "Disconnected from Device.");
      }
      final service = await bluetoothManager.getTargetService(
        Guid(BluetoothConstants.serviceUuid),
      );
      final response = await bluetoothManager.writeJsonAndWaitForResponse(
        service: service,
        charUuid: Guid(BluetoothConstants.charUuid),
        payload: {"signal": signal},
      );
      if (response == null) {
        throw LocalException(message: "No Response from Device.");
      }
      if (response["error_status"] == "1") {
        throw LocalException(message: "Card Not Found.");
      }
      if (response["error_status"] == "2") {
        throw LocalException(message: "Card Authentication Failed.");
      }
      if (response["error_status"] == "3") {
        throw LocalException(message: "Card Write Failed.");
      }
      return response["mode"];
    } on LocalException catch (e) {
      throw LocalException(message: e.message);
    } catch (_) {
      throw LocalException(message: "Exception in BLE.");
    }
  }
}
