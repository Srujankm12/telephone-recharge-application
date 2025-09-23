import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:telephone_recharge_application/core/constants/bluetooth_constants.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/utils/telephone_bluetooth_manager.dart';
import 'package:telephone_recharge_application/features/recharge/data/models/recharge_model.dart';

abstract interface class RechargeLocalDatasource {
  Future<bool> rechargeCard({required RechargeModel rechargeDetails});
  RechargeModel getUserCredentials();
  Future<bool> checkInternetConnection();
}

class RechargeLocalDatasourceImpl implements RechargeLocalDatasource {
  final TelephoneBluetoothManager bluetoothManager;
  final Box<String> box;
  final InternetConnection connection;
  RechargeLocalDatasourceImpl({
    required this.bluetoothManager,
    required this.box,
    required this.connection,
  });
  @override
  Future<bool> rechargeCard({required RechargeModel rechargeDetails}) async {
    try {
      if (!await bluetoothManager.checkBluetoothState()) {
        await bluetoothManager.turnOnBluetooth();
      }
      if (!await bluetoothManager.isConnected()) {
        throw LocalException(message: "Not Connected to Device.");
      }
      final service = await bluetoothManager.getTargetService(
        Guid(BluetoothConstants.serviceUuid),
      );
      final response = await bluetoothManager.writeJsonAndWaitForResponse(
        service: service,
        charUuid: Guid(BluetoothConstants.charUuid),
        payload: {
          "signal": rechargeDetails.signal,
          "amount": rechargeDetails.amount,
        },
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
      throw LocalException(message: "Exception with Device Communication.");
    }
  }

  @override
  RechargeModel getUserCredentials() {
    try {
      final String? userId = box.get("user_id");
      final String? collegeId = box.get("college_id");
      final String? machineId = box.get("machine_id");
      if (userId == null || collegeId == null || machineId == null) {
        throw LocalException(message: "User Credentials Not Found.");
      }
      return RechargeModel(
        userId: userId,
        collegeId: collegeId,
        machineId: machineId,
        amount: "",
        signal: "",
      );
    } on LocalException catch (e) {
      throw LocalException(message: e.message);
    } catch (_) {
      throw LocalException(
        message: "Exception while Getting User Credentials.",
      );
    }
  }

  @override
  Future<bool> checkInternetConnection() {
    // TODO: implement checkInternetConnection
    throw UnimplementedError();
  }
}
