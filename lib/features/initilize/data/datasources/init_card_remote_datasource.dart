import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:telephone_recharge_application/core/constants/http_constants.dart';
import 'package:telephone_recharge_application/core/constants/http_routes.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/features/initilize/data/models/user_credentials_model.dart';

abstract interface class InitCardRemoteDatasource {
  Future<bool> checkInternetConnection();
  Future<bool> deductAmountFromDatabase({
    required UserCredentialsModel userCredentials,
  });
}

class InitCardRemoteDatasourceImpl implements InitCardRemoteDatasource {
  final http.Client client;
  final InternetConnection connection;
  InitCardRemoteDatasourceImpl({
    required this.client,
    required this.connection,
  });
  @override
  Future<bool> deductAmountFromDatabase({
    required UserCredentialsModel userCredentials,
  }) async {
    try {
      final jsonResponse = await client.post(
        Uri.parse(
          "${HttpRoutes.deductAmount}/${userCredentials.collegeId}/${userCredentials.machineId}",
        ),
        body: jsonEncode({
          "user_id": userCredentials.userId,
          "amount": userCredentials.amount,
        }),
        headers: HttpConstants.httpHeaders,
      );
      final response = jsonDecode(jsonResponse.body);
      if (jsonResponse.statusCode != 200) {
        throw ServerException(message: response["error"]);
      }
      return true;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (_) {
      throw ServerException(message: "Error while Deducting Amount.");
    }
  }

  @override
  Future<bool> checkInternetConnection() async {
    return await connection.hasInternetAccess;
  }
}
