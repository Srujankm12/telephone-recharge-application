import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/core/usecase/usecase.dart';
import 'package:telephone_recharge_application/features/authentication/login/domain/entities/login_request_entity.dart';
import 'package:telephone_recharge_application/features/authentication/login/domain/repository/auth_repository.dart';

class LoginUsecase implements Usecase<String,LoginParams>{
  final AuthRepository authRepository;
  const LoginUsecase({required this.authRepository});
  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    return await authRepository.loginRequest(userDetails: LoginRequestEntity(email: params.email, password: params.password));
  }
}

class LoginParams {
  final String email;
  final String password;
  LoginParams({required this.email , required this.password});
}