import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/features/devices/data/datasources/devices_local_datasource.dart';
import 'package:telephone_recharge_application/features/devices/domain/entities/ble_device_entity.dart';
import 'package:telephone_recharge_application/features/devices/domain/repository/devices_repository.dart';

class DevicesRepositoryImpl implements DevicesRepository {
  final DevicesLocalDatasource devicesLocalDatasource;

  DevicesRepositoryImpl({required this.devicesLocalDatasource});

  @override
  Future<Either<Failure, Stream<BleDeviceEntity>>> getBleDevices() async {
    try {
      final deviceStream = devicesLocalDatasource.getBleDevices();

      final entityStream = deviceStream.map<BleDeviceEntity>(
        (device) => device,
      );

      return Right(entityStream);
    } on LocalException catch (e) {
      return Left(Failure(message: e.message));
    } catch (_) {
      return Left(Failure(message: "Error in stream repository"));
    }
  }
}
