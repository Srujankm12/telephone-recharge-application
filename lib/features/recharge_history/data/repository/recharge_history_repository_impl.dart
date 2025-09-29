import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/features/recharge_history/data/datasources/recharge_history_local_datasource.dart';
import 'package:telephone_recharge_application/features/recharge_history/data/datasources/recharge_history_remote_datasource.dart';
import 'package:telephone_recharge_application/features/recharge_history/data/models/recharge_history_model.dart';
import 'package:telephone_recharge_application/features/recharge_history/domain/entities/recharge_history_entity.dart';
import 'package:telephone_recharge_application/features/recharge_history/domain/repository/recharge_history_repository.dart';

class RechargeHistoryRepositoryImpl implements RechargeHistoryRepository {
  final RechargeHistoryLocalDatasource rechargeHistoryLocalDatasource;
  final RechargeHistoryRemoteDatasource rechargeHistoryRemoteDatasource;
  RechargeHistoryRepositoryImpl({
    required this.rechargeHistoryLocalDatasource,
    required this.rechargeHistoryRemoteDatasource,
  });
  @override
  Future<Either<Failure, List<RechargeHistoryEntity>>>
  getRechargeHistory() async {
    try {
      if (!await rechargeHistoryLocalDatasource.checkInternetConnection()) {
        throw LocalException(message: "No Internet Connection.");
      }
      final String machineId = await rechargeHistoryLocalDatasource
          .getMachineId();
      final List<RechargeHistoryModel> response =
          await rechargeHistoryRemoteDatasource.getRechargeHistory(
            userId: machineId,
          );
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    } on LocalException catch (e) {
      return Left(Failure(message: e.message));
    } catch (_) {
      return Left(Failure(message: "Error Occured While Fetching Details."));
    }
  }
}
