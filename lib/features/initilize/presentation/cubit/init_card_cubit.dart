import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/features/initilize/domain/usecases/init_card_usecase.dart';

part 'init_card_state.dart';

class InitCardCubit extends Cubit<InitCardState> {
  final InitCardUsecase _initCardUsecase;
  InitCardCubit({required InitCardUsecase initCardUsecase})
    : _initCardUsecase = initCardUsecase,
      super(InitCardInitial());

  Future<void> initCard({
    required String signal,
    required String mode,
    required String amount,
  }) async {
    final res = await _initCardUsecase(
      InitCardParams(signal: signal, amount: amount, mode: mode),
    );
    res.fold(
      (failure) {
        emit(InitCardFailureState(message: failure.message));
      },
      (success) {
        emit(InitCardSuccessState(message: success));
      },
    );
  }
}
