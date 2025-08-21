import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/features/devices/domain/entities/ble_device_entity.dart';

abstract interface class DevicesRepository {
  Future<Either<Failure,Stream<BleDeviceEntity>>> getBleDevices();
}