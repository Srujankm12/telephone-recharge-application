import 'dart:convert';

import 'package:telephone_recharge_application/core/constants/http_routes.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/features/balance/data/models/balance_model.dart';
import 'package:http/http.dart' as http;

abstract interface class BalanceRemoteDatasource {
  Future<String> getMachineBalance({
    required BalanceModel userDetails,
  });
}

class BalanceRemoteDatasourceImpl implements BalanceRemoteDatasource {
  final http.Client client;
  BalanceRemoteDatasourceImpl({required this.client});
  @override
  Future<String> getMachineBalance({required BalanceModel userDetails}) async {
    try {
      final jsonResponse = await http.post(Uri.parse(HttpRoutes.balance) , body: jsonEncode(userDetails) , headers: HttpRoutes.jsonHeaders);
      final response = jsonDecode(jsonResponse.body);
      if(jsonResponse.statusCode != 200){
        throw ServerException(message: response["error"]);
      }
      return response["balance"];
    } on ServerException catch (e) {
      throw LocalException(message: e.message);
    } catch (_) {
      throw ServerException(message: "Error Fetching Balance.");
    }
  }
}