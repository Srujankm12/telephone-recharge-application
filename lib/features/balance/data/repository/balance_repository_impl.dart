import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/features/balance/data/datasources/balance_local_datasource.dart';
import 'package:telephone_recharge_application/features/balance/data/datasources/balance_remote_datasource.dart';
import 'package:telephone_recharge_application/features/balance/data/models/balance_model.dart';
import 'package:telephone_recharge_application/features/balance/domain/repository/balance_repository.dart';

class BalanceRepositoryImpl implements BalanceRepository{
  final BalanceRemoteDatasource balanceRemoteDatasource;
  final BalanceLocalDatasource balanceLocalDatasource;
  BalanceRepositoryImpl({required this.balanceLocalDatasource , required this.balanceRemoteDatasource});
  @override
  Future<Either<Failure, String>> getCardBalance() async {
    try {
      final BalanceModel userDetails = await balanceLocalDatasource.getUserDetails();
      final response = await balanceRemoteDatasource.getMachineBalance(userDetails: userDetails);
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    } on LocalException catch (e) {
      return Left(Failure(message: e.message));
    } catch (e) {
      return Left(Failure(message: "Exception while Fetching the Balance."));
    }
  }
}