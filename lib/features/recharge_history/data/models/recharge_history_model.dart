import 'package:telephone_recharge_application/features/recharge_history/domain/entities/recharge_history_entity.dart';

class RechargeHistoryModel extends RechargeHistoryEntity {
  RechargeHistoryModel({
    required super.userId,
    required super.date,
    required super.rechargeAmount,
    required super.time,
  });

  factory RechargeHistoryModel.fromJson(Map<String, dynamic> json) {
    return RechargeHistoryModel(
      userId: json["user_id"],
      date: json["date"],
      rechargeAmount: json["recharge_amount"],
      time: json["time"],
    );
  }
}
