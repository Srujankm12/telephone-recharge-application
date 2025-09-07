import 'package:hive/hive.dart';
import 'package:telephone_recharge_application/core/errors/exceptions.dart';
import 'package:telephone_recharge_application/features/recharge_history/data/models/recharge_history_user_details_model.dart';

abstract interface class RechargeHistoryLocalDatasource {
  Future<RechargeHistoryUserDetailsModel> getUserDetails({
    required String amount,
  });
}

class RechargeHistoryLocalDatasourceImpl
    implements RechargeHistoryLocalDatasource {
  final Box<String> box;
  RechargeHistoryLocalDatasourceImpl({required this.box});
  @override
  Future<RechargeHistoryUserDetailsModel> getUserDetails({
    required String amount,
  }) async {
    try {
      final String? userId = box.get("user_id");
      if (userId == null) {
        throw LocalException(message: "Invalid User Credentials.");
      }
      return RechargeHistoryUserDetailsModel(amount: amount, userId: userId);
    } on LocalException catch (e) {
      throw LocalException(message: e.message);
    } catch (_) {
      throw LocalException(message: "Exception while Getting User Details.");
    }
  }
}
