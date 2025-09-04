import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/features/initilize/data/datasources/init_card_local_datasource.dart';
import 'package:telephone_recharge_application/features/initilize/data/models/init_card_restricted_model.dart';
import 'package:telephone_recharge_application/features/initilize/domain/entities/init_card_restricted_entity.dart';
import 'package:telephone_recharge_application/features/initilize/domain/repository/init_card_repository.dart';

class InitCardRepositoryImpl implements InitCardRepository {
  final InitCardLocalDatasource initCardLocalDatasource;
  InitCardRepositoryImpl({required this.initCardLocalDatasource});
  @override
  Future<Either<Failure, String>> initCardFreeToDial() {
    // TODO: implement initCardFreeToDial
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> initCardRistricted({
    required InitCardRestrictedEntity cardDetails,
  }) async {
    try {
      final response = await initCardLocalDatasource.initRestrictedMode(
        restrictedModeDetails: InitCardRestrictedModel(
          amount: cardDetails.amount,
          phoneNumbers: cardDetails.phoneNumbers,
          signal: cardDetails.signal,
          mode: cardDetails.mode,
        ),
      );
      if (response) {
        return Right("Card initilization Successfull.");
      }
      return Left(Failure(message: "Card initilization Failed."));
    } catch (_) {
      return Left(
        Failure(message: "Card initilization Failed with Exception."),
      );
    }
  }
}
