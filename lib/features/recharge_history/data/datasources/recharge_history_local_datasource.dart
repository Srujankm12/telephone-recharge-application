import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';

abstract interface class RechargeHistoryLocalDatasource {
  Future<String> getMachineId();
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
  Future<String> getMachineId() async {
    try {
      final String? machineId = box.get("machine_id");
      if (machineId == null) {
        throw LocalException(message: "Machine ID Not Found.");
      }
      return machineId;
    } on LocalException catch (e) {
      throw LocalException(message: e.message);
    } catch (_) {
      throw LocalException(message: "Exception in HIVE.");
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
