part of 'get_ble_devices_cubit.dart';

@immutable
sealed class GetBleDevicesState {}

final class GetBleDevicesInitial extends GetBleDevicesState {}

final class GetBleDevicesSuccessState extends GetBleDevicesState {
  final Stream<>
}

final class GetBleDevicesFailureState extends GetBleDevicesState {}
