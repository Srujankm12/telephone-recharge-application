import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/core/usecase/usecase.dart';
import 'package:telephone_recharge_application/features/phone_number/domain/repository/phone_number_repository.dart';

class GetCardModeUsecase implements Usecase<String, String> {
  final PhoneNumberRepository phoneNumberRepository;
  GetCardModeUsecase({required this.phoneNumberRepository});
  @override
  Future<Either<Failure, String>> call(String params) async {
    return await phoneNumberRepository.checkCardMode(signal: params);
  }
}
