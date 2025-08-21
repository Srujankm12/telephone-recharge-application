import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/features/devices/domain/usecases/get_ble_devices_usecase.dart';

part 'get_ble_devices_state.dart';

class GetBleDevicesCubit extends Cubit<GetBleDevicesState> {
  final GetBleDevicesUsecase _getBleDevicesUsecase;
  GetBleDevicesCubit({required GetBleDevicesUsecase getBleDevicesUsecase})
    : _getBleDevicesUsecase = getBleDevicesUsecase,
      super(GetBleDevicesInitial());

  Future<void> getBleDevices() async {
    final res = await _getBleDevicesUsecase(null);
    res.fold((failure) {
      emit();
    }, (success) {});
  }
}
