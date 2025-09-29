import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/features/mode/domain/usecases/check_card_mode_usecase.dart';

part 'get_card_mode_state.dart';

class GetCardModeCubit extends Cubit<GetCardModeState> {
  final CheckCardModeUsecase _checkCardModeUsecase;
  GetCardModeCubit({required CheckCardModeUsecase checkCardModeUsecase})
    : _checkCardModeUsecase = checkCardModeUsecase,
      super(GetCardModeInitial());

  Future<void> checkCardMode() async {
    emit(GetCardModeLoadingState());
    final res = await _checkCardModeUsecase("6");
    res.fold(
      (failure) {
        emit(GetCardModeFailureState(message: failure.message));
      },
      (success) {
        emit(GetCardModeSuccessState(cardMode: success));
      },
    );
  }
}
