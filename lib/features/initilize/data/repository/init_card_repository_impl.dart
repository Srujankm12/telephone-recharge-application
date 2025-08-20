import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/features/initilize/domain/entities/init_card_restricted_entity.dart';
import 'package:telephone_recharge_application/features/initilize/domain/repository/init_card_repository.dart';

class InitCardRepositoryImpl implements InitCardRepository {
  @override
  Future<Either<Failure, String>> initCardFreeToDial() {
    // TODO: implement initCardFreeToDial
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> initCardRistricted(InitCardRestrictedEntity cardDetails) {
    // TODO: implement initCardRistricted
    throw UnimplementedError();
  }
}