import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/core/usecase/usecase.dart';
import 'package:telephone_recharge_application/features/balance/domain/repository/balance_repository.dart';

class GetBalanceUsecase implements Usecase<String,dynamic>{
  final BalanceRepository balanceRepository;
  GetBalanceUsecase({required this.balanceRepository});
  @override
  Future<Either<Failure, String>> call(params) async {
    return await balanceRepository.getCardBalance();
  }
}