import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/features/initilize/domain/entities/init_card_restricted_entity.dart';

abstract interface class InitCardRepository {
  Future<Either<Failure, String>> initCardRistricted({
    required InitCardRestrictedEntity cardDetails,
  });
  Future<Either<Failure, String>> initCardFreeToDial();
}
