import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/features/recharge/domain/usecases/recharge_usecase.dart';

part 'recharge_state.dart';

class RechargeCubit extends Cubit<RechargeState> {
  final RechargeUsecase _rechargeUsecase;
  RechargeCubit({required RechargeUsecase rechargeUsecase})
    : _rechargeUsecase = rechargeUsecase,
      super(RechargeInitial());

  Future<void> rechargeCard({required String amount}) async {
    emit(RechargeLoadingState());
    final res = await _rechargeUsecase(
      RechargeParams(signal: "5", amount: amount),
    );
    res.fold(
      (failure) {
        emit(RechargeFailureState(message: failure.message));
      },
      (success) {
        emit(RechargeSuccessState(message: success));
      },
    );
  }
}
