import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/utils/telephone_bluetooth_manager.dart';
import 'package:telephone_recharge_application/features/initilize/data/models/init_card_restricted_model.dart';
import 'package:http/http.dart' as http;

abstract interface class InitCardLocalDatasource {
  Future<String> initRestrictedMode({
    required InitCardRestrictedModel restrictedModeDetails,
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
  Future<String> initRestrictedMode({
    required InitCardRestrictedModel restrictedModeDetails,
  }) async {
    try {
      final service = await bluetoothManager.getTargetService(Guid(""));
      final response = await bluetoothManager.writeJsonAndWaitForResponse(
        service: service,
        charUuid: Guid(""),
        payload: restrictedModeDetails.toJson(),
      );
      return "Done";
    } catch (_) {
      throw LocalException(message: "");
    }
  }
}
