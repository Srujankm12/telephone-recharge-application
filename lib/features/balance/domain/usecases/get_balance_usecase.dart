import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/core/usecase/usecase.dart';
import 'package:telephone_recharge_application/features/balance/domain/repository/balance_repository.dart';

class GetBalanceUsecase implements Usecase<String, String> {
  final BalanceRepository balanceRepository;
  GetBalanceUsecase({required this.balanceRepository});
  @override
  Future<Either<Failure, String>> call(signal) async {
    return await balanceRepository.getCardBalance(signal: signal);
  }
}
