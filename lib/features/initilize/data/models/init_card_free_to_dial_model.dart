import 'package:telephone_recharge_application/features/initilize/domain/entities/init_card_free_to_dial_entity.dart';

class InitCardFreeToDialModel extends InitCardFreeToDialEntity {
  InitCardFreeToDialModel({
    required super.signal,
    required super.mode,
    required super.amount,
  });

  Map<String, dynamic> toJson() {
    return {"signal": signal, "mode": mode, "amount": amount};
  }
}
