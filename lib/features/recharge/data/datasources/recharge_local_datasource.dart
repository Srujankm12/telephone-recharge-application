import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:telephone_recharge_application/core/constants/bluetooth_constants.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/utils/telephone_bluetooth_manager.dart';
import 'package:telephone_recharge_application/features/recharge/data/models/recharge_model.dart';

abstract interface class RechargeLocalDatasource {
  Future<bool> rechargeCard({required RechargeModel rechargeDetails});
  Future<Map<String, dynamic>> getUserCredentials();
}

class RechargeLocalDatasourceImpl implements RechargeLocalDatasource {
  final TelephoneBluetoothManager bluetoothManager;
  RechargeLocalDatasourceImpl({required this.bluetoothManager});
  @override
  Future<bool> rechargeCard({required RechargeModel rechargeDetails}) async {
    try {
      final service = await bluetoothManager.getTargetService(
        Guid(BluetoothConstants.serviceUuid),
      );
      final response = await bluetoothManager.writeJsonAndWaitForResponse(
        service: service,
        charUuid: Guid(BluetoothConstants.charUuid),
        payload: rechargeDetails.toBluetoothJson(),
      );
      if (response == null) {
        throw LocalException(message: "No Response from the Device.");
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
      return true;
    } on LocalException catch (e) {
      throw LocalException(message: e.message);
    } catch (_) {
      throw LocalException(message: "Exception in Bluetooth Communication.");
    }
  }
}
