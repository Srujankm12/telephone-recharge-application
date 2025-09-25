import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';

abstract interface class AuthLocalDatasource {
  Future<bool> saveUserDetails({required String token});
  String getToken();
  Future<bool> checkInternetConnection();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final Box<String> box;
  final InternetConnection connection;
  const AuthLocalDatasourceImpl({required this.box, required this.connection});
  @override
  String getToken() {
    try {
      final String? token = box.get("token");
      if (token == null) {
        throw LocalException(message: "Token not Found.");
      }
      return token;
    } on LocalException catch (e) {
      throw LocalException(message: e.message);
    } catch (_) {
      throw LocalException(message: "Exception in HIVE.");
    }
  }

  @override
  Future<bool> saveUserDetails({required String token}) async {
    try {
      final Map<String, dynamic> response = JwtDecoder.decode(token);
      await box.put("token", token);
      await box.put("user_id", response["user_id"]);
      await box.put("user_name", response["user_name"]);
      await box.put("machine_id", response["machine_id"]);
      await box.put("college_id", response["college_id"]);
      return true;
    } catch (_) {
      throw LocalException(message: "Exception in JWT or HIVE.");
    }
  }

  @override
  Future<bool> checkInternetConnection() async {
    try {
      return await connection.hasInternetAccess;
    } catch (e) {
      throw LocalException(message: "Exception in Internet Connection.");
    }
  }
}
