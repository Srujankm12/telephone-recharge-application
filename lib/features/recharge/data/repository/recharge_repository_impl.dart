import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/features/recharge/data/datasources/recharge_local_datasource.dart';
import 'package:telephone_recharge_application/features/recharge/data/datasources/recharge_remote_datasource.dart';
import 'package:telephone_recharge_application/features/recharge/data/models/recharge_model.dart';
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
      final userCredentials = rechargeLocalDatasource.getUserCredentials();
      final bluetoothResponse = await rechargeLocalDatasource.rechargeCard(
        rechargeDetails: RechargeModel(
          signal: signal,
          amount: amount,
          machineId: userCredentials.machineId,
          collegeId: userCredentials.collegeId,
          userId: userCredentials.userId,
        ),
      );
      if (!bluetoothResponse) {
        throw LocalException(message: "Error In Bluetooth Communication.");
      }
      final httpResponse = await rechargeRemoteDatasource
          .deductAmountFromDatabase(
            rechargeDetails: RechargeModel(
              signal: signal,
              amount: amount,
              machineId: userCredentials.machineId,
              collegeId: userCredentials.collegeId,
              userId: userCredentials.userId,
            ),
          );
      if (!httpResponse) {
        throw ServerException(message: "Error In Server Communication.");
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
