import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/features/initilize/data/datasources/init_card_local_datasource.dart';
import 'package:telephone_recharge_application/features/initilize/data/datasources/init_card_remote_datasource.dart';
import 'package:telephone_recharge_application/features/initilize/data/models/init_card_free_to_dial_model.dart';
import 'package:telephone_recharge_application/features/initilize/data/models/init_card_restricted_model.dart';
import 'package:telephone_recharge_application/features/initilize/data/models/user_credentials_model.dart';
import 'package:telephone_recharge_application/features/initilize/domain/entities/init_card_free_to_dial_entity.dart';
import 'package:telephone_recharge_application/features/initilize/domain/entities/init_card_restricted_entity.dart';
import 'package:telephone_recharge_application/features/initilize/domain/repository/init_card_repository.dart';

class InitCardRepositoryImpl implements InitCardRepository {
  final InitCardLocalDatasource initCardLocalDatasource;
  final InitCardRemoteDatasource initCardRemoteDatasource;
  InitCardRepositoryImpl({
    required this.initCardLocalDatasource,
    required this.initCardRemoteDatasource,
  });
  @override
  Future<Either<Failure, String>> initCardFreeToDial({
    required InitCardFreeToDialEntity cardDetails,
  }) async {
    try {
      if (!await initCardRemoteDatasource.checkInternetConnection()) {
        throw LocalException(message: "No Internet Connection.");
      }
      final UserCredentialsModel userCredentials = initCardLocalDatasource
          .getUserCredentials(amount: cardDetails.amount);
      final bool httpResponse = await initCardRemoteDatasource
          .deductAmountFromDatabase(userCredentials: userCredentials);
      if (!httpResponse) {
        throw ServerException(message: "Card Initilization Failed.");
      }
      final response = await initCardLocalDatasource.initFreeToDialMode(
        freeToDialModeDetails: InitCardFreeToDialModel(
          signal: cardDetails.signal,
          mode: cardDetails.mode,
          amount: cardDetails.amount,
        ),
      );
      if (!response) {
        throw LocalException(message: "Card Initilization Failed.");
      }
      return Right("Card Initilized Successfully.");
    } on LocalException catch (e) {
      return Left(Failure(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    } catch (_) {
      return Left(Failure(message: "Exception while Initilizing Card."));
    }
  }

  @override
  Future<Either<Failure, String>> initCardRistricted({
    required InitCardRestrictedEntity cardDetails,
  }) async {
    try {
      if (!await initCardRemoteDatasource.checkInternetConnection()) {
        throw LocalException(message: "No Internet Connection.");
      }
      final UserCredentialsModel userCredentials = initCardLocalDatasource
          .getUserCredentials(amount: cardDetails.amount);
      final bool httpResponse = await initCardRemoteDatasource
          .deductAmountFromDatabase(userCredentials: userCredentials);
      if (!httpResponse) {
        throw ServerException(message: "Card Initilization Failed.");
      }
      final response = await initCardLocalDatasource.initRestrictedMode(
        restrictedModeDetails: InitCardRestrictedModel(
          amount: cardDetails.amount,
          phoneNumbers: cardDetails.phoneNumbers,
          signal: cardDetails.signal,
          mode: cardDetails.mode,
        ),
      );
      if (!response) {
        throw LocalException(message: "Card Initilization Failed");
      }
      return Right("Card Initilized Successfully.");
    } on LocalException catch (e) {
      return Left(Failure(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    } catch (_) {
      return Left(Failure(message: "Exception while Initilizing Card."));
    }
  }
}
