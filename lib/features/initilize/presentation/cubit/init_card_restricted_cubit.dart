import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/features/initilize/domain/usecases/init_card_restricted_usecase.dart';

part 'init_card_restricted_state.dart';

class InitCardRestrictedCubit extends Cubit<InitCardRestrictedState> {
  final InitCardRestrictedUsecase _initCardRestrictedUsecase;
  InitCardRestrictedCubit({
    required InitCardRestrictedUsecase initCardRestrictedUsecase,
  }) : _initCardRestrictedUsecase = initCardRestrictedUsecase,
       super(InitCardRestrictedInitial());

  Future<void> initCardRestrictedMode({
    required String amount,
    required List<String> phoneNumbers,
  }) async {
    emit(InitCardRestrictedLoadingState());
    final res = await _initCardRestrictedUsecase(
      InitCardRestrictedParams(
        signal: "2",
        mode: "2",
        amount: amount,
        phoneNumbers: phoneNumbers,
      ),
    );
    res.fold(
      (failure) {
        emit(InitCardRestrictedFailureState(message: failure.message));
      },
      (success) {
        emit(InitCardRestrictedSuccessState(message: success));
      },
    );
  }
}
