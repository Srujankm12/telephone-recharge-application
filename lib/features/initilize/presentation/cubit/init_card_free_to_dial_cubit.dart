import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/features/initilize/domain/usecases/init_card_free_to_dial_usecase.dart';

part 'init_card_free_to_dial_state.dart';

class InitCardFreeToDialCubit extends Cubit<InitCardFreeToDialState> {
  final InitCardFreeToDialUsecase _initCardFreeToDialUsecase;
  InitCardFreeToDialCubit({
    required InitCardFreeToDialUsecase initCardFreeToDialUsecase
  }) : _initCardFreeToDialUsecase = initCardFreeToDialUsecase ,super(InitCardFreeToDialInitial());

  Future<void> initCardFreeToDial({
    required String amount,
  }) async {
    emit(InitCardFreeToDialLoadingState());
    final res = await _initCardFreeToDialUsecase(InitCardFreeToDialUsecaseParams(signal: "2", amount: amount, mode: "1"));
    res.fold((failure) {
    emit(InitCardFreeToDialFailureState(message: failure.message));
    }, (success){
      emit(InitCardFreeToDialSuccessState(message: success));
    });
  }
}
