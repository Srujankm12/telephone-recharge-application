import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';

abstract interface class ModeRepository {
  Future<Either<Failure, String>> checkCardMode({required String signal});
  Future<Either<Failure, String>> changeCardMode({
    required String signal,
    required String mode,
  });
}
