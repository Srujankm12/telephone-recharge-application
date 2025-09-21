import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:telephone_recharge_application/core/constants/bluetooth_constants.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/utils/telephone_bluetooth_manager.dart';

abstract interface class BalanceLocalDatasource {
  Future<String> getCardBalance({required String signal});
}

class BalanceLocalDatasourceImpl implements BalanceLocalDatasource {
  final TelephoneBluetoothManager bluetoothManager;
  BalanceLocalDatasourceImpl({required this.bluetoothManager});

  @override
  Future<String> getCardBalance({required String signal}) async {
    try {
      if (!await bluetoothManager.checkBluetoothState()) {
        await bluetoothManager.turnOnBluetooth();
        throw LocalException(message: "Bluetooth is Turned OFF.");
      }
      if (!await bluetoothManager.isConnected()) {
        throw LocalException(message: "Device is Disconnected.");
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
        throw LocalException(message: "No Response from the Machine.");
      }
      if (response["error_status"] == "1") {
        throw LocalException(message: "Card Not Found.");
      }
      if (response["error_status"] == "2") {
        throw LocalException(message: "Card Authentication Failed.");
      }
      if (response["error_status"] == "3") {
        throw LocalException(message: "Card Read Failed.");
      }
      return response["balance"];
    } on LocalException catch (e) {
      throw LocalException(message: e.message);
    } catch (_) {
      throw LocalException(message: "Exception in BLE.");
    }
  }
}
