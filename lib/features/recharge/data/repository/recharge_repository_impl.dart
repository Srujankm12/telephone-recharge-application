import 'package:dartz/dartz.dart';
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
  Future<Either<Failure, String>> rechargeCard() {
    
  }
}
