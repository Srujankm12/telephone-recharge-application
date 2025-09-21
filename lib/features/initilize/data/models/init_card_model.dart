import 'package:telephone_recharge_application/features/initilize/domain/entities/init_card_entity.dart';

class InitCardModel extends InitCardEntity {
  InitCardModel({
    required super.signal,
    required super.amount,
    required super.mode,
  });

  Map<String, String> toJson() {
    return {"signal": signal, "mode": mode, "amount": amount};
  }
}
