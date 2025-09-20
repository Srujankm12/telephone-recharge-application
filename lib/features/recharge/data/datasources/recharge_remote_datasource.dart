import 'dart:convert';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:telephone_recharge_application/core/constants/http_constants.dart';
import 'package:telephone_recharge_application/core/constants/http_routes.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/features/recharge/data/models/recharge_model.dart';
import 'package:http/http.dart' as http;

abstract interface class RechargeRemoteDatasource {
  Future<bool> deductAmountFromDatabase({
    required RechargeModel rechargeDetails,
  });
  Future<bool> checkInternetConnection();
}

class RechargeRemoteDatasourceImpl implements RechargeRemoteDatasource {
  final http.Client client;
  final InternetConnection connection;
  RechargeRemoteDatasourceImpl({
    required this.client,
    required this.connection,
  });
  @override
  Future<bool> deductAmountFromDatabase({
    required RechargeModel rechargeDetails,
  }) async {
    try {
      final jsonResponse = await client.post(
        Uri.parse(
          "${HttpRoutes.deductAmount}/${rechargeDetails.collegeId}/${rechargeDetails.amount}",
        ),
        body: jsonEncode(rechargeDetails),
        headers: HttpConstants.httpHeaders,
      );
      final response = jsonDecode(jsonResponse.body);
      if (jsonResponse.statusCode != 200) {
        throw ServerException(message: response["error"]);
      }
      return response["message"];
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (_) {
      throw ServerException(
        message: "Exception While Communicating with Server.",
      );
    }
  }

  @override
  Future<bool> checkInternetConnection() async {
    try {
      return await connection.hasInternetAccess;
    } catch (e) {
      throw ServerException(
        message: "Exception while Checking Internet Connection.",
      );
    }
  }
}
