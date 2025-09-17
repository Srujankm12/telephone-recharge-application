import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/core/usecase/usecase.dart';
import 'package:telephone_recharge_application/features/initilize/domain/entities/init_card_free_to_dial_entity.dart';
import 'package:telephone_recharge_application/features/initilize/domain/repository/init_card_repository.dart';

class InitCardFreeToDialUsecase
    implements Usecase<String, InitCardFreeToDialUsecaseParams> {
  final InitCardRepository initCardRepository;
  InitCardFreeToDialUsecase({required this.initCardRepository});
  @override
  Future<Either<Failure, String>> call(
    InitCardFreeToDialUsecaseParams params,
  ) async {
    return await initCardRepository.initCardFreeToDial(
      cardDetails: InitCardFreeToDialEntity(
        signal: params.signal,
        mode: params.mode,
        amount: params.amount,
      ),
    );
  }
}

class InitCardFreeToDialUsecaseParams {
  final String signal;
  final String mode;
  final String amount;
  InitCardFreeToDialUsecaseParams({
    required this.signal,
    required this.amount,
    required this.mode,
  });
}
