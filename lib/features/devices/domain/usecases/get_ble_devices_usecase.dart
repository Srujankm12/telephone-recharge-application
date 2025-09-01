import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/core/usecase/usecase.dart';
import 'package:telephone_recharge_application/features/devices/domain/entities/ble_device_entity.dart';
import 'package:telephone_recharge_application/features/devices/domain/repository/devices_repository.dart';

class GetBleDevicesUsecase implements Usecase<Stream<BleDeviceEntity>,dynamic> {
  final DevicesRepository devicesRepository;
  GetBleDevicesUsecase({required this.devicesRepository});
  @override
  Future<Either<Failure, Stream<BleDeviceEntity>>> call(params) async {
    return await devicesRepository.getBleDevices();
  }
}