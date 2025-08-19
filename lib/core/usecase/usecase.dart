import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';

abstract interface class Usecase<SuccessType,Params>{
  Future<Either<Failure,SuccessType>> call(Params params);
}