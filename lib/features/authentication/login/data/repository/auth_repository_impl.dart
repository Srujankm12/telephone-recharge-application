import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/features/authentication/login/data/datasources/auth_local_datasource.dart';
import 'package:telephone_recharge_application/features/authentication/login/data/datasources/auth_remote_datasource.dart';
import 'package:telephone_recharge_application/features/authentication/login/data/models/login_request_model.dart';
import 'package:telephone_recharge_application/features/authentication/login/domain/entities/login_request_entity.dart';
import 'package:telephone_recharge_application/features/authentication/login/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;
  const AuthRepositoryImpl({
    required this.authRemoteDatasource,
    required this.authLocalDatasource,
  });
  @override
  Future<Either<Failure, String>> loginRequest({
    required LoginRequestEntity userDetails,
  }) async {
    try {
      final token = await authRemoteDatasource.loginRequest(
        userDetails: LoginRequestModel(
          email: userDetails.email,
          password: userDetails.password,
        ),
      );
      final isUserDetailsSaved = await authLocalDatasource.saveUserDetails(
        token: token,
      );
      if (!isUserDetailsSaved) {
        return Left(Failure(message: "Error While saving User Details."));
      }
      return Right("Login Successfull.");
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    } on LocalException catch (e) {
      return Left(Failure(message: e.message));
    } catch (_) {
      return Left(Failure(message: "Error While Logging In User."));
    }
  }

  @override
  Either<Failure, String> autoLoginRequest() {
    try {
      return Right(authLocalDatasource.getToken());
    } on LocalException catch (e) {
      return Left(Failure(message: e.message));
    } catch (_) {
      return Left(
        Failure(message: "Error While getting Token from Local Storage."),
      );
    }
  }
}
