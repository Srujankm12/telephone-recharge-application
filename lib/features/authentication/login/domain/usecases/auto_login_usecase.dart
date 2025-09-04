import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/core/usecase/usecase.dart';
import 'package:telephone_recharge_application/features/authentication/login/domain/repository/auth_repository.dart';

class AutoLoginUsecase implements Usecase<String?,dynamic> {
  final AuthRepository authRepository;
  const AutoLoginUsecase({
    required this.authRepository,
  });
  @override
  Future<Either<Failure, String?>> call(params) async {
    return authRepository.autoLoginRequest();
  }
}