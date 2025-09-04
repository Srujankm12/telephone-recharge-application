import 'dart:async';
import 'dart:convert';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class TelephoneBluetoothManager {
  static final TelephoneBluetoothManager _instance =
      TelephoneBluetoothManager._internal();

  factory TelephoneBluetoothManager() {
    return _instance;
  }

  TelephoneBluetoothManager._internal();

  BluetoothDevice? _connectedDevice;

  Future<void> startScan({
    Duration timeout = const Duration(seconds: 10),
  }) async {
    await FlutterBluePlus.startScan(timeout: timeout);
  }

  Stream<List<ScanResult>> scanResults() {
    return FlutterBluePlus.scanResults;
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
    _connectedDevice = device;
  }

  Future<void> reconnectToDevice() async {
    if (_connectedDevice == null) return;
    var state = await _connectedDevice!.connectionState.first;
    if (state != BluetoothConnectionState.connected) {
      await _connectedDevice!.connect(autoConnect: true);
    }
  }

  Future<void> disconnectFromDevice() async {
    await _connectedDevice?.disconnect();
  }

  Stream<BluetoothConnectionState> connectionStatus() {
    return _connectedDevice!.connectionState;
  }

  Future<BluetoothService> getTargetService(Guid serviceUuid) async {
    List<BluetoothService> services = await _connectedDevice!
        .discoverServices();
    return services.firstWhere((s) => s.uuid == serviceUuid);
  }

  Future<bool> checkBluetoothState() async {
    final BluetoothAdapterState state = FlutterBluePlus.adapterStateNow;
    if(state == BluetoothAdapterState.off){
      return false;
    }
    return true;
  }

  Future<void> turnOnBluetooth() async {
    await FlutterBluePlus.turnOn();
  }

  Future<Map<String, dynamic>?> writeJsonAndWaitForResponse({
    required BluetoothService service,
    required Guid charUuid,
    required Map<String, dynamic> payload,
    Duration timeout = const Duration(seconds: 5),
  }) async {
    try {
      // 1. Get the characteristic
      final characteristic = service.characteristics.firstWhere(
        (c) =>
            c.uuid == charUuid && (c.properties.write || c.properties.notify),
      );

      // 2. Enable notifications
      await characteristic.setNotifyValue(true);

      // 3. Setup completer to wait for response
      final completer = Completer<Map<String, dynamic>?>();
      final requestJson = jsonEncode(payload); // store request string

      // 4. Listen for incoming notifications
      final sub = characteristic.lastValueStream.listen((data) {
        try {
          if (data.isEmpty) return; // ignore empty packets

          final responseStr = utf8.decode(data);
          print(responseStr);

          if (responseStr.trim().isEmpty) return; // ignore empty strings

          final responseJson = jsonDecode(responseStr) as Map<String, dynamic>;

          // Ignore echoed request
          if (responseStr == requestJson) return;

          if (!completer.isCompleted) {
            completer.complete(responseJson);
          }
        } catch (e) {
          if (!completer.isCompleted) {
            completer.completeError(Exception({"message": e.toString()}));
          }
        }
      });

      // 5. Write JSON request
      final dataToSend = utf8.encode(requestJson);
      await characteristic.write(dataToSend, withoutResponse: false);

      // 6. Wait for response or timeout
      final result = await completer.future.timeout(
        timeout,
        onTimeout: () => null,
      );

      // 7. Cleanup
      await sub.cancel();

      return result;
    } catch (e) {
      throw Exception({"message": "exception in BLE communication"});
    }
  }
}
