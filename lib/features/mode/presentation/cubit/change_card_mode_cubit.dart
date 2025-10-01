import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/features/mode/domain/usecases/change_card_mode_usecase.dart';

part 'change_card_mode_state.dart';

class ChangeCardModeCubit extends Cubit<ChangeCardModeState> {
  final ChangeCardModeUsecase _changeCardModeUsecase;
  ChangeCardModeCubit({required ChangeCardModeUsecase changeCardModeUsecase})
    : _changeCardModeUsecase = changeCardModeUsecase,
      super(ChangeCardModeInitial());

  Future<void> changeCardMode({
    required String signal,
    required String mode,
  }) async {
    emit(ChangeCardModeLoadingState());
    final res = await _changeCardModeUsecase(
      ChangeCardModeParams(signal: signal, mode: mode),
    );
    res.fold(
      (failure) {
        emit(ChangeCardModeFailureState(message: failure.message));
      },
      (success) {
        emit(ChangeCardModeSuccessState(message: success));
      },
    );
  }
}
