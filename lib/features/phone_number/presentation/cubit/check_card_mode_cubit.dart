import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/features/phone_number/domain/usecases/get_card_mode_usecase.dart';

part 'check_card_mode_state.dart';

class CheckCardModeCubit extends Cubit<CheckCardModeState> {
  final GetCardModeUsecase _getCardModeUsecase;
  CheckCardModeCubit({required GetCardModeUsecase getCardModeUsecase})
    : _getCardModeUsecase = getCardModeUsecase,
      super(CheckCardModeInitial());

  Future<void> checkCardMode() async {
    emit(CheckCardModeLoadingState());
    final res = await _getCardModeUsecase("6");
    res.fold(
      (failure) {
        emit(CheckCardModeFailureState(message: failure.message));
      },
      (success) {
        if (success == "2") {
          emit(CheckCardModeSuccessState(cardMode: "Valid Card Mode."));
        } else {
          emit(CheckCardModeFailureState(message: "Invalid Card Mode."));
        }
      },
    );
  }
}
