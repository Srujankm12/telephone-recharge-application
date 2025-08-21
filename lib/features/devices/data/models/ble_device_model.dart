import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:telephone_recharge_application/features/devices/domain/entities/ble_device_entity.dart';

class BleDeviceModel extends BleDeviceEntity {
  BleDeviceModel({
    required super.deviceID,
    required super.deviceName,
    required super.isLoading,
  });

  factory BleDeviceModel.fromResult(ScanResult res) {
    return BleDeviceModel(
      deviceID: res.device.advName,
      deviceName: res.device.remoteId.toString(),
      isLoading: false,
    );
  }
}
