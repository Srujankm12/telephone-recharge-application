part of 'connect_to_ble_device_cubit.dart';

@immutable
sealed class ConnectToBleDeviceState {}

final class ConnectToBleDeviceInitial extends ConnectToBleDeviceState {}

final class ConnectToBleDeviceSuccessState extends ConnectToBleDeviceState {
  final bool connectionStatus;
  final BluetoothDevice device;
  ConnectToBleDeviceSuccessState({
    required this.connectionStatus,
    required this.device,
  });
}

final class ConnectToBleDeviceFailureState extends ConnectToBleDeviceState {
  final String message;
  ConnectToBleDeviceFailureState({required this.message});
}

final class ConnectToBleDeviceLoadingState extends ConnectToBleDeviceState {
  final int index;
  ConnectToBleDeviceLoadingState({required this.index});
}
