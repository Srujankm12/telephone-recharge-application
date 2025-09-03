import 'package:dartz/dartz.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';

abstract interface class DevicesRepository {
  Future<Either<Failure, Stream<List<ScanResult>>>> getBleDevices();
  Future<Either<Failure, bool>> connectToDevice({
    required BluetoothDevice device,
  });
}
