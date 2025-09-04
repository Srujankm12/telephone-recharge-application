import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/features/authentication/login/domain/entities/login_request_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure,String>> loginRequest({required LoginRequestEntity userDetails});
  Either<Failure,String?> autoLoginRequest();
}