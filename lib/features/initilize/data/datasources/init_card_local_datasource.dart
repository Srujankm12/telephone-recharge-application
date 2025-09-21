import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:telephone_recharge_application/core/constants/bluetooth_constants.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/utils/telephone_bluetooth_manager.dart';
import 'package:telephone_recharge_application/features/initilize/data/models/init_card_model.dart';
import 'package:telephone_recharge_application/features/initilize/data/models/user_credentials_model.dart';

abstract interface class InitCardLocalDatasource {
  Future<bool> checkInternetConnection();
  Future<bool> initCardMode({required InitCardModel cardModeDetails});
  UserCredentialsModel getUserCredentials({required String amount});
}

class InitCardLocalDatasourceImpl implements InitCardLocalDatasource {
  final TelephoneBluetoothManager bluetoothManager;
  final Box<String> box;
  final InternetConnection connection;

  InitCardLocalDatasourceImpl({
    required this.bluetoothManager,
    required this.box,
    required this.connection,
  });

  @override
  Future<bool> initCardMode({required InitCardModel cardModeDetails}) async {
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
        payload: cardModeDetails.toJson(),
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
  UserCredentialsModel getUserCredentials({required String amount}) {
    try {
      final String? userId = box.get("user_id");
      final String? machineId = box.get("machine_id");
      final String? collegeId = box.get("college_id");
      if (userId == null || machineId == null || collegeId == null) {
        throw LocalException(message: "User Credentials Not Found.");
      }
      return UserCredentialsModel(
        userId: userId,
        machineId: machineId,
        collegeId: collegeId,
        amount: amount,
      );
    } on LocalException catch (e) {
      throw LocalException(message: e.message);
    } catch (e) {
      throw LocalException(message: "Exception in HIVE.");
    }
  }

  @override
  Future<bool> checkInternetConnection() async {
    try {
      return await connection.hasInternetAccess;
    } catch (e) {
      throw LocalException(message: "Exception in Internet Connection.");
    }
  }
}
