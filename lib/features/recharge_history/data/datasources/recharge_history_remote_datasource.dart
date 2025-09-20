import 'dart:convert';

import 'package:telephone_recharge_application/core/constants/http_constants.dart';
import 'package:telephone_recharge_application/core/constants/http_routes.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/features/recharge_history/data/models/recharge_history_model.dart';
import 'package:http/http.dart' as http;

abstract interface class RechargeHistoryRemoteDatasource {
  Future<List<RechargeHistoryModel>> getRechargeHistory({
    required String userId,
  });
}

class RechargeHistoryRemoteDatasourceImpl
    implements RechargeHistoryRemoteDatasource {
  final http.Client client;
  RechargeHistoryRemoteDatasourceImpl({required this.client});
  @override
  Future<List<RechargeHistoryModel>> getRechargeHistory({
    required String userId,
  }) async {
    try {
      final jsonResponse = await client.get(
        Uri.parse("${HttpRoutes.rechargeHistory}/$userId"),
        headers: HttpConstants.httpHeaders,
      );
      final response = jsonDecode(jsonResponse.body);
      print(response);
      if (jsonResponse.statusCode != 200) {
        throw ServerException(message: response["error"]);
      }
      if (response["data"] == null) {
        throw ServerException(message: "No Recharge History to Display.");
      }
      return (response["data"] as List)
          .map((ele) => RechargeHistoryModel.fromJson(ele))
          .toList();
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (_) {
      throw ServerException(
        message: "Error Getting Recharge History from Server.",
      );
    }
  }
}
