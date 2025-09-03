import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/utils/telephone_bluetooth_manager.dart';

abstract interface class DevicesLocalDatasource {
  Future<Stream<List<ScanResult>>> getBleDevices();
  Future<bool> connectToDevice({required BluetoothDevice device});
}

class DevicesLocalDatasourceImpl implements DevicesLocalDatasource {
  final TelephoneBluetoothManager bluetoothManager;

  DevicesLocalDatasourceImpl({required this.bluetoothManager});

  @override
  Future<Stream<List<ScanResult>>> getBleDevices() async {
    try {
      await bluetoothManager.startScan();
      return bluetoothManager.scanResults();
    } catch (_) {
      throw LocalException(message: "Error getting devices. Try again.");
    }
  }

  @override
  Future<bool> connectToDevice({required BluetoothDevice device}) async {
    try {
      await bluetoothManager.connectToDevice(device);
      final status = await bluetoothManager.connectionStatus().firstWhere(
        (s) =>
            s == BluetoothConnectionState.connected ||
            s == BluetoothConnectionState.disconnected,
      );
      return status == BluetoothConnectionState.connected;
    } catch (e) {
      return false;
    }
  }
}
