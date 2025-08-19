import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';

abstract interface class InitCardRepository {
  Future<Either<Failure, String>> initCardRistricted();
  Future<Either<Failure, String>> initCardFreeToDial();
}
