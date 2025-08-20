import 'package:telephone_recharge_application/features/initilize/domain/entities/init_card_restricted_entity.dart';

class InitCardRestrictedModel extends InitCardRestrictedEntity {
  InitCardRestrictedModel({
    required super.amount,
    required super.phoneNumbers,
    required super.signal,
    required super.mode,
  });

  Map<String, dynamic> toJson() {
    return {
      "signal": signal,
      "mode": mode,
      "amount": amount,
      "phone_numbers": phoneNumbers,
    };
  }
}
