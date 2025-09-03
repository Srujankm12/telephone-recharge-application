import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:telephone_recharge_application/features/devices/domain/usecases/connect_to_ble_device_usecase.dart';

part 'connect_to_ble_device_state.dart';

class ConnectToBleDeviceCubit extends Cubit<ConnectToBleDeviceState> {
  final ConnectToBleDeviceUsecase _connectToBleDeviceUsecase;
  ConnectToBleDeviceCubit({
    required ConnectToBleDeviceUsecase connectToBleDeviceUsecase,
  }) : _connectToBleDeviceUsecase = connectToBleDeviceUsecase,
       super(ConnectToBleDeviceInitial());

  Future<void> connectToBleDevice({
    required BluetoothDevice device,
    required int index,
  }) async {
    emit(ConnectToBleDeviceLoadingState(index: index));
    final res = await _connectToBleDeviceUsecase(
      ConnectToBleDeviceParams(device: device),
    );
    res.fold(
      (failure) {
        emit(ConnectToBleDeviceFailureState(message: failure.message));
      },
      (success) {
        emit(ConnectToBleDeviceSuccessState(connectionStatus: success));
      },
    );
  }
}
