import 'package:dartz/dartz.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/core/usecase/usecase.dart';
import 'package:telephone_recharge_application/features/devices/domain/repository/devices_repository.dart';

class ConnectToBleDeviceUsecase
    implements Usecase<bool, ConnectToBleDeviceParams> {
  final DevicesRepository devicesRepository;
  ConnectToBleDeviceUsecase({required this.devicesRepository});
  @override
  Future<Either<Failure, bool>> call(params) async {
    return await devicesRepository.connectToDevice(device: params.device);
  }
}

class ConnectToBleDeviceParams {
  final BluetoothDevice device;
  ConnectToBleDeviceParams({required this.device});
}
