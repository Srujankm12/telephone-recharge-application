import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hive/hive.dart';
import 'package:telephone_recharge_application/core/constants/bluetooth_constants.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/utils/telephone_bluetooth_manager.dart';
import 'package:telephone_recharge_application/features/initilize/data/models/init_card_free_to_dial_model.dart';
import 'package:telephone_recharge_application/features/initilize/data/models/init_card_restricted_model.dart';
import 'package:telephone_recharge_application/features/initilize/data/models/user_credentials_model.dart';

abstract interface class InitCardLocalDatasource {
  Future<bool> initRestrictedMode({
    required InitCardRestrictedModel restrictedModeDetails,
  });
  Future<bool> initFreeToDialMode({
    required InitCardFreeToDialModel freeToDialModeDetails,
  });
  UserCredentialsModel getUserCredentials({
    required String amount,
  });
}

class InitCardLocalDatasourceImpl implements InitCardLocalDatasource {
  final TelephoneBluetoothManager bluetoothManager;
  final Box<String> box;

  InitCardLocalDatasourceImpl({
    required this.bluetoothManager,
    required this.box,
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
      if(response["error_status"] == "1"){
        throw LocalException(message: "Card Not Found.");
      }
      if(response["error_status"] == "2"){
        throw LocalException(message: "Card Authentication Failed.");
      }
      if(response["error_status"] == "3"){
        throw LocalException(message: "Card Write Failed.");
      }
      return false;
    } on LocalException catch (e) {
      throw LocalException(message: e.message);
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
      if(response["error_status"] == "1"){
        throw LocalException(message: "Card Not Found.");
      }
      if(response["error_status"] == "2"){
        throw LocalException(message: "Card Authentication Failed.");
      }
      if(response["error_status"] == "3"){
        throw LocalException(message: "Card Write Failed.");
      }
      return false;
    } on LocalException catch (e) {
      throw LocalException(message: e.message);
    } catch (_) {
      throw LocalException(message: "Error while Initilizing.");
    }
  }
  
  @override
  UserCredentialsModel getUserCredentials({
    required String amount,
  }) {
    try {
      final String? userId = box.get("user_id");
      final String? machineId = box.get("machine_id");
      final String? collegeId = box.get("college_id");
      if(userId == null || machineId == null || collegeId == null){
        throw LocalException(message: "Invalid User Credentials.");
      }
      return UserCredentialsModel(
        userId: userId, 
        machineId: machineId, 
        collegeId: collegeId, 
        amount: amount
      );
    } on LocalException catch (e) {
      throw LocalException(message: e.message);
    } catch (e) {
      throw LocalException(message: "Error Fetching User Credentials.");
    }
  }
}
