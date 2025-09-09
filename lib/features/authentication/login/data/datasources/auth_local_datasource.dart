import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';

abstract interface class AuthLocalDatasource {
  Future<bool> saveUserDetails({required String token});
  String getToken();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final Box<String> box;
  const AuthLocalDatasourceImpl({required this.box});
  @override
  String getToken() {
    try {
      final String? token = box.get("token");
      if (token == null) {
        throw LocalException(message: "Token not Found.");
      }
      return token;
    } catch (_) {
      throw LocalException(message: "Error Getting token From Local Storage.");
    }
  }

  @override
  Future<bool> saveUserDetails({required String token}) async {
    try {
      final response = JwtDecoder.decode(token);
      await box.put("token", token);
      await box.put("user_id", response["user_id"]);
      await box.put("user_name", response["user_name"]);
      await box.put("", response["machine_id"]);
      await box.put("college_id", response["college_id"]);
      return true;
    } catch (_) {
      throw LocalException(message: "Failed to save User Details.");
    }
  }
}
