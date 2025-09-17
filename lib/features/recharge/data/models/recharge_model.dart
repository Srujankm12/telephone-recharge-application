import 'package:telephone_recharge_application/features/recharge/domain/entities/recharge_entity.dart';

class RechargeModel extends RechargeEntity {
  RechargeModel({required super.signal, required super.amount});

  Map<String, String> toJson() {
    return {"signal": signal, "amount": amount};
  }
}
