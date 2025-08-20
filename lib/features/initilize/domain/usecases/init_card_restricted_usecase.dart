import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/core/usecase/usecase.dart';

class InitCardRestrictedUsecase implements Usecase<String,InitCardRestrictedParams>{
  @override
  Future<Either<Failure, String>> call(InitCardRestrictedParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}


class InitCardRestrictedParams{
  final String signal;
  final String mode;
  final String amount;
  final List<String> phoneNumbers;
  InitCardRestrictedParams({required this.signal , required this.mode , required this.amount , required this.phoneNumbers});
}