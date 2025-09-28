import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/features/phone_number/domain/usecases/add_phone_number_usecase.dart';

part 'add_phone_numbers_state.dart';

class AddPhoneNumbersCubit extends Cubit<AddPhoneNumbersState> {
  final AddPhoneNumberUsecase _addPhoneNumberUsecase;
  AddPhoneNumbersCubit({required AddPhoneNumberUsecase addPhoneNumberUsecase})
    : _addPhoneNumberUsecase = addPhoneNumberUsecase,
      super(AddPhoneNumbersInitial());

  Future<void> addPhoneNumbers({
    required String signal,
    required List<String> phoneNumbers,
  }) async {
    emit(AddPhoneNumbersLoadingState());
    final res = await _addPhoneNumberUsecase(
      AddPhoneNumberParams(signal: signal, phoneNumbers: phoneNumbers),
    );
    res.fold(
      (failure) {
        emit(AddPhoneNumbersFailureState(message: failure.message));
      },
      (success) {
        emit(AddPhoneNumbersSuccessState(message: success));
      },
    );
  }
}
