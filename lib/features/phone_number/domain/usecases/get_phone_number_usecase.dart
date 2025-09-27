import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/core/usecase/usecase.dart';
import 'package:telephone_recharge_application/features/phone_number/domain/repository/phone_number_repository.dart';

class GetPhoneNumberUsecase implements Usecase<List<String>, String> {
  final PhoneNumberRepository phoneNumberRepository;
  GetPhoneNumberUsecase({required this.phoneNumberRepository});
  @override
  Future<Either<Failure, List<String>>> call(String params) async {
    return await phoneNumberRepository.getPhoneNumbers(signal: params);
  }
}
