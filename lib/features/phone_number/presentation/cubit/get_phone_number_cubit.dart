import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/features/phone_number/domain/usecases/get_phone_number_usecase.dart';

part 'get_phone_number_state.dart';

class GetPhoneNumberCubit extends Cubit<GetPhoneNumberState> {
  final GetPhoneNumberUsecase _getPhoneNumberUsecase;
  GetPhoneNumberCubit({required GetPhoneNumberUsecase getPhoneNumberUsecase})
    : _getPhoneNumberUsecase = getPhoneNumberUsecase,
      super(GetPhoneNumberInitial());

  Future<void> getPhoneNumbers() async {
    final res = await _getPhoneNumberUsecase("7");
    res.fold(
      (failure) {
        emit(GetPhoneNumbersFailureState(message: failure.message));
      },
      (success) {
        emit(GetPhoneNumbersSuccessState(phoneNumbers: success));
      },
    );
  }
}
