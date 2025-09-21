import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/features/initilize/domain/entities/init_card_entity.dart';

abstract interface class InitCardRepository {
  Future<Either<Failure, String>> initCard({
    required InitCardEntity cardDetails,
  });
}
