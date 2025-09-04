import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/features/authentication/login/domain/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase _loginUsecase;
  LoginCubit({
    required LoginUsecase loginUsecase,
  }) : _loginUsecase = loginUsecase , super(LoginInitial());

  Future<void> loginRequest({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    final res = await _loginUsecase(LoginParams(email: email, password: password));
    res.fold((failure){
      emit(LoginFailureState(message: failure.message));
    }, (success){
      emit(LoginSuccessState(message: success));
    });
  }
}
