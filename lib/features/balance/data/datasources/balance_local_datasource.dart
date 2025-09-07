import 'package:hive/hive.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/features/balance/data/models/balance_model.dart';

abstract interface class BalanceLocalDatasource {
  Future<BalanceModel> getUserDetails();
}

class BalanceLocalDatasourceImpl implements BalanceLocalDatasource{
  final Box<String> box;
  BalanceLocalDatasourceImpl({required this.box});
  @override
  Future<BalanceModel> getUserDetails() async {
    try {
      final String? userId = box.get("user_id");
      final String? machineId = box.get("machine_id");
      final String? collegeId = box.get("college_id");

      if(userId == null || collegeId == null || machineId == null){
        throw LocalException(message: "Error Fetching User Details.");
      }
      return BalanceModel(userId: userId, collegeId: collegeId, machineId: machineId);
    } on LocalException catch (e) {
      throw LocalException(message: e.message);
    } catch (_) {
      throw LocalException(message: "Error in User Details.");
    }
  }  
}