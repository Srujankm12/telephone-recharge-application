part of 'get_ble_devices_cubit.dart';

@immutable
sealed class GetBleDevicesState {}

final class GetBleDevicesInitial extends GetBleDevicesState {}

final class GetBleDevicesSuccessState extends GetBleDevicesState {
  final Stream<List<ScanResult>> devices;
  GetBleDevicesSuccessState({required this.devices});
}

final class GetBleDevicesFailureState extends GetBleDevicesState {
  final String message;
  GetBleDevicesFailureState({required this.message});
}

final class GetBleDeviceLoadingState extends GetBleDevicesState {}
