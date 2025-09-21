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
      final Stream<List<ScanResult>> devicesStream = await devicesLocalDatasource
          .getBleDevices();
      return Right(devicesStream);
    } on LocalException catch (e) {
      return Left(Failure(message: e.message));
    } catch (_) {
      return Left(Failure(message: "Error in BLE Communication."));
    }
  }

  @override
  Future<Either<Failure, bool>> connectToBleDevice({
    required BluetoothDevice device,
  }) async {
    try {
      final status = await devicesLocalDatasource.connectToBleDevice(
        device: device,
      );
      return Right(status);
    } on LocalException catch (e) {
      return Left(Failure(message: e.message));
    } catch (_) {
      return Left(Failure(message: "Error in BLE Communication."));
    }
  }
}
