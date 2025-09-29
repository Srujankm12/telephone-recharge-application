import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/features/phone_number/data/datasources/phone_number_local_datasource.dart';
import 'package:telephone_recharge_application/features/phone_number/domain/repository/phone_number_repository.dart';

class PhoneNumberRepositoryImpl implements PhoneNumberRepository {
  final PhoneNumberLocalDatasource phoneNumberLocalDatasource;
  PhoneNumberRepositoryImpl({required this.phoneNumberLocalDatasource});
  @override
  Future<Either<Failure, String>> addPhoneNumbers({
    required String signal,
    required List<String> phoneNumbers,
  }) async {
    try {
      final response = await phoneNumberLocalDatasource.addPhoneNumber(
        signal: signal,
        phoneNumbers: phoneNumbers,
      );
      if (!response) {
        throw LocalException(message: "Error in Adding Phone Number.");
      }
      return Right("Phone Number Added Successfully.");
    } on LocalException catch (e) {
      return Left(Failure(message: e.message));
    } catch (_) {
      return Left(
        Failure(message: "Exception in Phone Number Addition Process."),
      );
    }
  }

  @override
  Future<Either<Failure, String>> checkCardMode({
    required String signal,
  }) async {
    try {
      final response = await phoneNumberLocalDatasource.checkCardMode(
        signal: signal,
      );
      print(response);
      return Right(response);
    } on LocalException catch (e) {
      return Left(Failure(message: e.message));
    } catch (_) {
      return Left(Failure(message: "Exception Fetching Card Mode."));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPhoneNumbers({
    required String signal,
  }) async {
    try {
      final response = await phoneNumberLocalDatasource.getExistingPhoneNumbers(
        signal: signal,
      );
      return Right(response);
    } on LocalException catch (e) {
      return Left(Failure(message: e.message));
    } catch (_) {
      return Left(Failure(message: "Exception Getting Phone Numbers."));
    }
  }
}
