import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/features/balance/domain/usecases/get_balance_usecase.dart';

part 'get_balance_state.dart';

class GetBalanceCubit extends Cubit<GetBalanceState> {
  final GetBalanceUsecase _getBalanceUsecase;
  GetBalanceCubit({required GetBalanceUsecase getBalanceUsecase})
    : _getBalanceUsecase = getBalanceUsecase,
      super(GetBalanceInitial());

  Future<void> getBalance() async {
    emit(GetBalanceLoadingState());
    final response = await _getBalanceUsecase("4");
    response.fold(
      (failure) {
        emit(GetBalanceFailureState(message: failure.message));
      },
      (success) {
        emit(GetBalanceSuccessState(balance: success));
      },
    );
  }
}
