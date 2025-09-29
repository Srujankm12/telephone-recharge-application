import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/features/mode/data/datasources/mode_local_datasource.dart';
import 'package:telephone_recharge_application/features/mode/domain/repository/mode_repository.dart';

class ModeRepositoryImpl implements ModeRepository {
  final ModeLocalDatasource modeLocalDatasource;
  ModeRepositoryImpl({required this.modeLocalDatasource});
  @override
  Future<Either<Failure, String>> changeCardMode({
    required String signal,
    required String mode,
  }) async {
    try {
      final response = await modeLocalDatasource.changeCardMode(
        signal: signal,
        mode: mode,
      );
      return Right(response);
    } on LocalException catch (e) {
      return Left(Failure(message: e.message));
    } catch (_) {
      return Left(Failure(message: "Exception Changing Card Mode."));
    }
  }

  @override
  Future<Either<Failure, String>> checkCardMode({
    required String signal,
  }) async {
    try {
      final response = await modeLocalDatasource.checkCardMode(signal: signal);
      return Right(response);
    } on LocalException catch (e) {
      return Left(Failure(message: e.message));
    } catch (_) {
      return Left(Failure(message: "Exception Fetching Card Mode."));
    }
  }
}
