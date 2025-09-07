import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/features/recharge_history/domain/entities/recharge_history_entity.dart';

abstract interface class RechargeHistoryRepository {
  Future<Either<Failure, List<RechargeHistoryEntity>>> getRechargeHistory();
}
