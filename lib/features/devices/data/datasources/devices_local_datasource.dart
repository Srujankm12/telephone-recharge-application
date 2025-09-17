import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/utils/telephone_bluetooth_manager.dart';

abstract interface class DevicesLocalDatasource {
  Future<Stream<List<ScanResult>>> getBleDevices();
  Future<bool> connectToBleDevice({required BluetoothDevice device});
}

class DevicesLocalDatasourceImpl implements DevicesLocalDatasource {
  final TelephoneBluetoothManager bluetoothManager;
  DevicesLocalDatasourceImpl({required this.bluetoothManager});
  @override
  Future<Stream<List<ScanResult>>> getBleDevices() async {
    try {
      if (!await bluetoothManager.checkBluetoothState()) {
        await bluetoothManager.turnOnBluetooth();
      }
      if (await bluetoothManager.isConnected()) {
        await bluetoothManager.disconnectFromDevice();
      }
      await bluetoothManager.startScan();
      print("hello");
      return bluetoothManager.scanResults();
    } catch (e) {
      print(e.toString());
      throw LocalException(message: "Exception in Bluetooth Communication.");
    }
  }

  @override
  Future<bool> connectToBleDevice({required BluetoothDevice device}) async {
    try {
      if (!await bluetoothManager.checkBluetoothState()) {
        await bluetoothManager.turnOnBluetooth();
      }
      if (await bluetoothManager.isConnected()) {
        await bluetoothManager.disconnectFromDevice();
      }
      await bluetoothManager.connectToDevice(device);
      final status = await bluetoothManager.connectionStatus().firstWhere(
        (s) =>
            s == BluetoothConnectionState.connected ||
            s == BluetoothConnectionState.disconnected,
      );
      return status == BluetoothConnectionState.connected;
    } catch (_) {
      throw LocalException(message: "Exception in Bluetooth Communication.");
    }
  }
}
