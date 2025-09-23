import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/features/balance/data/datasources/balance_local_datasource.dart';
import 'package:telephone_recharge_application/features/balance/domain/repository/balance_repository.dart';

class BalanceRepositoryImpl implements BalanceRepository {
  final BalanceLocalDatasource balanceLocalDatasource;
  BalanceRepositoryImpl({required this.balanceLocalDatasource});
  @override
  Future<Either<Failure, String>> getCardBalance({
    required String signal,
  }) async {
    try {
      final response = await balanceLocalDatasource.getCardBalance(
        signal: signal,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    } on LocalException catch (e) {
      return Left(Failure(message: e.message));
    } catch (e) {
      return Left(Failure(message: "Error in BLE."));
    }
  }
}
