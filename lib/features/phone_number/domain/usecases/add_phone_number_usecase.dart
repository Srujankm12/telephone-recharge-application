import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/core/usecase/usecase.dart';
import 'package:telephone_recharge_application/features/phone_number/domain/repository/phone_number_repository.dart';

class AddPhoneNumberUsecase implements Usecase<String, AddPhoneNumberParams> {
  final PhoneNumberRepository phoneNumberRepository;
  AddPhoneNumberUsecase({required this.phoneNumberRepository});
  @override
  Future<Either<Failure, String>> call(AddPhoneNumberParams params) async {
    return await phoneNumberRepository.addPhoneNumbers(
      signal: params.signal,
      phoneNumbers: params.phoneNumbers,
    );
  }
}

class AddPhoneNumberParams {
  final String signal;
  final List<String> phoneNumbers;
  AddPhoneNumberParams({required this.signal, required this.phoneNumbers});
}
