import 'dart:convert';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class TelephoneBluetoothManager {
  static final TelephoneBluetoothManager _instance =
      TelephoneBluetoothManager._internal();

  factory TelephoneBluetoothManager() {
    return _instance;
  }

  TelephoneBluetoothManager._internal();

  final FlutterBluePlus _flutterBlue = FlutterBluePlus();

  BluetoothDevice? _connectedDevice;

  FlutterBluePlus get flutterBlue => _flutterBlue;

  Future<void> startScan({
    Duration timeout = const Duration(seconds: 10),
  }) async {
    await FlutterBluePlus.startScan(timeout: timeout);
  }

  Stream<List<ScanResult>> scanResults() {
    return FlutterBluePlus.onScanResults;
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
    _connectedDevice = device;
  }

  Future<BluetoothService> getTargetService(
    Guid serviceUuid,
  ) async {
    List<BluetoothService> services = await _connectedDevice!.discoverServices();
    return services.firstWhere((s) => s.uuid == serviceUuid);
  }

  Future<void> writeToDevice(
    BluetoothService service,
    Guid charactristic,
    dynamic payload,
  ) async {
    final characteristic = service.characteristics.firstWhere(
      (c) => c.uuid == charactristic && c.properties.write,
    );
    List<int> data = utf8.encode(payload);
    characteristic.write(data, withoutResponse: false);
  }
}
