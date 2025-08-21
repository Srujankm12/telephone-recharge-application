import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/utils/telephone_bluetooth_manager.dart';
import 'package:telephone_recharge_application/features/devices/data/models/ble_device_model.dart';

abstract interface class DevicesLocalDatasource {
  Stream<BleDeviceModel> getBleDevices();
}

class DevicesLocalDatasourceImpl implements DevicesLocalDatasource {
  final TelephoneBluetoothManager bluetoothManager;

  DevicesLocalDatasourceImpl({required this.bluetoothManager});

  @override
  Stream<BleDeviceModel> getBleDevices() async* {
    try {
      await bluetoothManager.startScan();
      await for (final deviceList in bluetoothManager.scanResults()) {
        for (final device in deviceList) {
          yield BleDeviceModel.fromResult(device);
        }
      }
    } catch (_) {
      throw LocalException(message: "Error getting devices. Try again.");
    }
  }
}
