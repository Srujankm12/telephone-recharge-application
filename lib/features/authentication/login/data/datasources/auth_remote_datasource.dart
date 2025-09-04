import 'dart:convert';

import 'package:telephone_recharge_application/core/constants/http_routes.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/features/authentication/login/data/models/login_request_model.dart';
import 'package:http/http.dart' as http;

abstract interface class AuthRemoteDatasource {
  Future<String> loginRequest({required LoginRequestModel userDetails});
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final http.Client client;
  const AuthRemoteDatasourceImpl({required this.client});
  @override
  Future<String> loginRequest({
    required LoginRequestModel userDetails,
  }) async {
    try {
      final jsonResponse = await client.post(
        Uri.parse(HttpRoutes.login), 
        body: userDetails.toJson(), 
        headers: HttpRoutes.jsonHeaders
      );
      final response = jsonDecode(jsonResponse.body);
      if(jsonResponse.statusCode != 200){
        throw ServerException(message: response["error"]);
      }
      return response["token"];
    } on ServerException catch(e) {
      throw ServerException(message: e.message);
    } catch (_) {
      throw ServerException(message: "Exception While Communicating with Server.");
    } 
  }
}