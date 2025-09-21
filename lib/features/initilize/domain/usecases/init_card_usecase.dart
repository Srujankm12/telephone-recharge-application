import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/core/usecase/usecase.dart';
import 'package:telephone_recharge_application/features/initilize/domain/entities/init_card_entity.dart';
import 'package:telephone_recharge_application/features/initilize/domain/repository/init_card_repository.dart';

class InitCardUsecase implements Usecase<String, InitCardParams> {
  final InitCardRepository initCardRepository;
  InitCardUsecase({required this.initCardRepository});
  @override
  Future<Either<Failure, String>> call(InitCardParams params) async {
    return await initCardRepository.initCard(
      cardDetails: InitCardEntity(
        signal: params.signal,
        amount: params.amount,
        mode: params.mode,
      ),
    );
  }
}

class InitCardParams {
  final String signal;
  final String mode;
  final String amount;
  InitCardParams({
    required this.signal,
    required this.amount,
    required this.mode,
  });
}
