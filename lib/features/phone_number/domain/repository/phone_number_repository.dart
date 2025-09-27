import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';

abstract interface class PhoneNumberRepository {
  Future<Either<Failure, List<String>>> getPhoneNumbers({
    required String signal,
  });
  Future<Either<Failure, String>> addPhoneNumbers({
    required String signal,
    required List<String> phoneNumbers,
  });
  Future<Either<Failure, String>> checkCardMode({required String signal});
}
