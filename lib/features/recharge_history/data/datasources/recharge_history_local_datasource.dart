import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';

abstract interface class RechargeHistoryLocalDatasource {
  Future<String> getUserId();
  Future<bool> checkInternetConnection();
}

class RechargeHistoryLocalDatasourceImpl
    implements RechargeHistoryLocalDatasource {
  final Box<String> box;
  final InternetConnection connection;
  RechargeHistoryLocalDatasourceImpl({
    required this.box,
    required this.connection,
  });
  @override
  Future<String> getUserId() async {
    try {
      final String? userId = box.get("user_id");
      if (userId == null) {
        throw LocalException(message: "Invalid User Credentials.");
      }
      return userId;
    } on LocalException catch (e) {
      throw LocalException(message: e.message);
    } catch (_) {
      throw LocalException(message: "Exception while Getting User ID.");
    }
  }

  @override
  Future<bool> checkInternetConnection() async {
    try {
      return await connection.hasInternetAccess;
    } catch (e) {
      throw LocalException(message: "Internet Connection Exception");
    }
  }
}
