import 'dart:convert';

import 'package:telephone_recharge_application/core/constants/http_routes.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/features/recharge/data/models/recharge_model.dart';
import 'package:http/http.dart' as http;

abstract interface class RechargeRemoteDatasource {
  Future<bool> deductAmountFromDatabase({
    required RechargeModel rechargeDetails,
  });
}

class RechargeRemoteDatasourceImpl implements RechargeRemoteDatasource {
  final http.Client client;
  RechargeRemoteDatasourceImpl({required this.client});
  @override
  Future<bool> deductAmountFromDatabase({
    required RechargeModel rechargeDetails,
  }) async {
    try {
      final jsonResponse = await client.post(
        Uri.parse(
          "${HttpRoutes.deductAmount}/${rechargeDetails.collegeId}/${rechargeDetails.amount}",
        ),
        body: rechargeDetails.toHttpJson(),
        headers: HttpRoutes.jsonHeaders,
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
}
