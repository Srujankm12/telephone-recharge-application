import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/core/usecase/usecase.dart';
import 'package:telephone_recharge_application/features/recharge_history/domain/entities/recharge_history_entity.dart';
import 'package:telephone_recharge_application/features/recharge_history/domain/repository/recharge_history_repository.dart';

class GetRechargeHistoryUsecase
    implements Usecase<List<RechargeHistoryEntity>, dynamic> {
  final RechargeHistoryRepository rechargeHistoryRepository;
  GetRechargeHistoryUsecase({required this.rechargeHistoryRepository});
  @override
  Future<Either<Failure, List<RechargeHistoryEntity>>> call(params) async {
    return await rechargeHistoryRepository.getRechargeHistory();
  }
}
