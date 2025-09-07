import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';

abstract interface class BalanceRepository {
  Future<Either<Failure,String>> getCardBalance();
}