import 'dart:convert';

import 'package:telephone_recharge_application/features/recharge/domain/entities/recharge_entity.dart';

class RechargeModel extends RechargeEntity {
  RechargeModel({
    required super.signal,
    required super.amount,
    required super.collegeId,
    required super.userId,
  });

  Map<String, String> toBluetoothJson() {
    return {"signal": signal, "amount": amount};
  }

  String toHttpJson() {
    return jsonEncode({"user_id": userId, "amount": amount});
  }
}
