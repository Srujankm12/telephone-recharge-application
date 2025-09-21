import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:telephone_recharge_application/core/constants/http_constants.dart';
import 'package:telephone_recharge_application/core/constants/http_routes.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/features/initilize/data/models/user_credentials_model.dart';

abstract interface class InitCardRemoteDatasource {
  Future<bool> deductAmountFromDatabase({
    required UserCredentialsModel userCredentials,
  });
}

class InitCardRemoteDatasourceImpl implements InitCardRemoteDatasource {
  final http.Client client;
  InitCardRemoteDatasourceImpl({required this.client});
  @override
  Future<bool> deductAmountFromDatabase({
    required UserCredentialsModel userCredentials,
  }) async {
    try {
      final jsonResponse = await client.post(
        Uri.parse(
          "${HttpRoutes.recharge}/${userCredentials.collegeId}/${userCredentials.machineId}/${userCredentials.userId}",
        ),
        body: jsonEncode({"recharge_amount": userCredentials.amount}),
        headers: HttpConstants.httpHeaders,
      );
      final response = jsonDecode(jsonResponse.body);
      if (response == null) {
        throw ServerException(message: "No Response from the Server.");
      }
      if (jsonResponse.statusCode != 200) {
        throw ServerException(message: response["error"]);
      }
      return true;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (_) {
      throw ServerException(message: "Exception in Server.");
    }
  }
}
