import 'package:dartz/dartz.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/features/devices/data/datasources/devices_local_datasource.dart';
import 'package:telephone_recharge_application/features/devices/domain/repository/devices_repository.dart';

class DevicesRepositoryImpl implements DevicesRepository {
  final DevicesLocalDatasource devicesLocalDatasource;

  DevicesRepositoryImpl({required this.devicesLocalDatasource});

  @override
  Future<Either<Failure, Stream<List<ScanResult>>>> getBleDevices() async {
    try {
      final deviceStream = await devicesLocalDatasource.getBleDevices();
      return Right(deviceStream);
    } on LocalException catch (e) {
      return Left(Failure(message: e.message));
    } catch (_) {
      return Left(Failure(message: "Error in stream repository"));
    }
  }

  @override
  Future<Either<Failure, bool>> connectToDevice({
    required BluetoothDevice device,
  }) async {
    try {
      final status = await devicesLocalDatasource.connectToDevice(
        device: device,
      );
      return Right(status);
    } catch (_) {
      return Left(Failure(message: "Bluetooth busy."));
    }
  }
}
