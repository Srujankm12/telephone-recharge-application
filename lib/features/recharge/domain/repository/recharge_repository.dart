import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';

abstract interface class RechargeRepository {
  Future<Either<Failure, String>> rechargeCard({
    required String signal,
    required String amount,
  });
}
