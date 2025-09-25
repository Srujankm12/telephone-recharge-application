import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/features/recharge/data/datasources/recharge_local_datasource.dart';
import 'package:telephone_recharge_application/features/recharge/data/datasources/recharge_remote_datasource.dart';
import 'package:telephone_recharge_application/features/recharge/domain/repository/recharge_repository.dart';

class RechargeRepositoryImpl implements RechargeRepository {
  final RechargeLocalDatasource rechargeLocalDatasource;
  final RechargeRemoteDatasource rechargeRemoteDatasource;
  RechargeRepositoryImpl({
    required this.rechargeLocalDatasource,
    required this.rechargeRemoteDatasource,
  });
  @override
  Future<Either<Failure, String>> rechargeCard({
    required String signal,
    required String amount,
  }) async {
    try {
      if (!await rechargeLocalDatasource.checkInternetConnection()) {
        throw ServerException(message: "No Internet Connection.");
      }
      final userCredentials = rechargeLocalDatasource.getUserCredentials(
        signal: signal,
        amount: amount,
      );
      final bluetoothResponse = await rechargeLocalDatasource.rechargeCard(
        rechargeDetails: userCredentials,
      );
      if (!bluetoothResponse) {
        throw LocalException(message: "Error in BLE.");
      }
      final httpResponse = await rechargeRemoteDatasource
          .deductAmountFromDatabase(
            rechargeDetails: userCredentials,
          );
      if (!httpResponse) {
        throw ServerException(message: "Error in Server.");
      }
      return Right("Recharge Successfull.");
    } on LocalException catch (e) {
      return Left(Failure(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    } catch (_) {
      return Left(Failure(message: "Exception In Recharge Process."));
    }
  }
}
