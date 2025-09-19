import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/core/usecase/usecase.dart';
import 'package:telephone_recharge_application/features/recharge/domain/repository/recharge_repository.dart';

class RechargeUsecase implements Usecase<String, RechargeParams> {
  final RechargeRepository rechargeRepository;
  RechargeUsecase({required this.rechargeRepository});
  @override
  Future<Either<Failure, String>> call(RechargeParams params) async {
    return await rechargeRepository.rechargeCard(
      signal: params.signal,
      amount: params.amount,
    );
  }
}

class RechargeParams {
  final String signal;
  final String amount;
  RechargeParams({required this.signal, required this.amount});
}
