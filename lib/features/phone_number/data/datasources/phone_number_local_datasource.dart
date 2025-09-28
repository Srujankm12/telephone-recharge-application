import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:telephone_recharge_application/core/constants/bluetooth_constants.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/utils/telephone_bluetooth_manager.dart';

abstract interface class PhoneNumberLocalDatasource {
  Future<bool> addPhoneNumber({
    required String signal,
    required List<String> phoneNumbers,
  });
  Future<List<String>> getExistingPhoneNumbers({required String signal});
  Future<String> checkCardMode({required String signal});
}

class PhoneNumberLocalDatasourceImpl implements PhoneNumberLocalDatasource {
  final TelephoneBluetoothManager bluetoothManager;
  PhoneNumberLocalDatasourceImpl({required this.bluetoothManager});
  @override
  Future<bool> addPhoneNumber({
    required String signal,
    required List<String> phoneNumbers,
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
        payload: {"signal": signal, "phone_numbers": phoneNumbers},
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
      return true;
    } on LocalException catch (e) {
      throw LocalException(message: e.message);
    } catch (_) {
      throw LocalException(message: "Exception in BLE.");
    }
  }

  @override
  Future<List<String>> getExistingPhoneNumbers({required String signal}) async {
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
      print(response);
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
      final responseString = (response["phone_numbers"] as List<dynamic>)
          .map((e) => e.toString())
          .toList();
      return responseString;
    } on LocalException catch (e) {
      throw LocalException(message: e.message);
    } catch (e) {
      print(e.toString());
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
