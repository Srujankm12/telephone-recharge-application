import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/features/recharge_history/domain/entities/recharge_history_entity.dart';
import 'package:telephone_recharge_application/features/recharge_history/domain/usecases/get_recharge_history_usecase.dart';

part 'get_recharge_history_state.dart';

class GetRechargeHistoryCubit extends Cubit<GetRechargeHistoryState> {
  final GetRechargeHistoryUsecase _rechargeHistoryUsecase;
  GetRechargeHistoryCubit({
    required GetRechargeHistoryUsecase rechargeHistoryUsecase,
  }) : _rechargeHistoryUsecase = rechargeHistoryUsecase,
       super(GetRechargeHistoryInitial());

  Future<void> getRechargeHistory() async {
    emit(GetRechargeHistoryLoadingState());
    final res = await _rechargeHistoryUsecase(null);
    res.fold(
      (failure) {
        emit(GetRechargeHistoryFailureState(message: failure.message));
      },
      (success) {
        emit(GetRechargeHistorySuccessState(rechargeHistory: success));
      },
    );
  }
}
