import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/features/authentication/login/domain/usecases/auto_login_usecase.dart';

part 'auto_login_state.dart';

class AutoLoginCubit extends Cubit<AutoLoginState> {
  final AutoLoginUsecase _autoLoginUsecase;
  AutoLoginCubit({
    required AutoLoginUsecase autoLoginUsecase,
  }) : _autoLoginUsecase = autoLoginUsecase , super(AutoLoginInitial());

  Future<void> autoLogin() async {
    emit(AutoLoginLoadingState());
    final res = await _autoLoginUsecase(null);
    res.fold((failure){
      emit(AutoLoginFailureState(message: failure.message));
    }, (success){
      emit(AutoLoginSuccessState());
    });
  }
}
