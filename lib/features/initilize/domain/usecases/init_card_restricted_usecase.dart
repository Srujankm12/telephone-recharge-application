import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/core/usecase/usecase.dart';
import 'package:telephone_recharge_application/features/initilize/domain/entities/init_card_restricted_entity.dart';
import 'package:telephone_recharge_application/features/initilize/domain/repository/init_card_repository.dart';

class InitCardRestrictedUsecase
    implements Usecase<String, InitCardRestrictedParams> {
  final InitCardRepository initCardRepository;
  InitCardRestrictedUsecase({required this.initCardRepository});
  @override
  Future<Either<Failure, String>> call(InitCardRestrictedParams params) async {
    return await initCardRepository.initCardRistricted(
      cardDetails: InitCardRestrictedEntity(
        amount: params.amount,
        phoneNumbers: params.phoneNumbers,
        signal: params.signal,
        mode: params.mode,
      ),
    );
  }
}

class InitCardRestrictedParams {
  final String signal;
  final String mode;
  final String amount;
  final List<String> phoneNumbers;
  InitCardRestrictedParams({
    required this.signal,
    required this.mode,
    required this.amount,
    required this.phoneNumbers,
  });
}
