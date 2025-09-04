import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/core/arguments/options_page_args.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/core/widgets/app_loading_widget.dart';
import 'package:telephone_recharge_application/core/widgets/app_snackbar.dart';
import 'package:telephone_recharge_application/features/devices/presentation/cubit/connect_to_ble_device_cubit.dart';
import 'package:telephone_recharge_application/features/devices/presentation/cubit/get_ble_devices_cubit.dart';
import 'package:telephone_recharge_application/features/devices/presentation/widgets/device_list_tile.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  bool _isScanning = true;
  Timer? _scanTimer;

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  @override
  void dispose() {
    _scanTimer?.cancel();
    super.dispose();
  }

  void _startScan() {
    setState(() => _isScanning = true);
    _scanTimer?.cancel();
    _scanTimer = Timer(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() => _isScanning = false);
      }
    });
    context.read<GetBleDevicesCubit>().getBleDevices();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectToBleDeviceCubit, ConnectToBleDeviceState>(
      listener: (context, state) {
        if (state is ConnectToBleDeviceSuccessState) {
          if (state.connectionStatus) {
            Navigator.pushNamed(
              context,
              "/options",
              arguments: OptionsPageArgs(device: state.device),
            );
          } else {
            AppSnackbar.showSnackBar("Not Connected to Bluetooth, Try Again.", context);
          }
        } else if (state is ConnectToBleDeviceFailureState) {
          AppSnackbar.showSnackBar(state.message, context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.bluetooth_audio_rounded),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Devices", style: Theme.of(context).textTheme.titleLarge),
              Row(
                children: [
                  Text(
                    _isScanning ? "Scanning for Devices" : "Scanning Done",
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(color: AppColors.grey),
                  ),
                  if (_isScanning) ...[
                    const SizedBox(width: 5),
                    const SizedBox(
                      width: 5.5,
                      height: 5.5,
                      child: CircularProgressIndicator(
                        color: AppColors.blue,
                        strokeCap: StrokeCap.round,
                        strokeWidth: 1,
                      ),
                    ),
                  ] else ...[
                    const SizedBox(width: 3),
                    Icon(Icons.done_rounded, color: AppColors.green, size: 13),
                  ],
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: _startScan,
              icon: const Icon(Icons.refresh_rounded),
            ),
          ],
        ),
        body: BlocBuilder<GetBleDevicesCubit, GetBleDevicesState>(
          builder: (context, state) {
            if (state is GetBleDevicesSuccessState) {
              return StreamBuilder(
                stream: state.devices,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const AppLoadingWidget();

                  final devices =
                      snapshot.data
                          ?.where((d) => d.device.advName.startsWith("TEL"))
                          .toList() ??
                      [];

                  if (devices.isEmpty) {
                    return Center(child: Text("No Ble Devices Found." , style: Theme.of(context).textTheme.labelLarge,),);
                  }

                  return ListView.builder(
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      final device = devices[index].device;
                      return BlocBuilder<
                        ConnectToBleDeviceCubit,
                        ConnectToBleDeviceState
                      >(
                        builder: (context, connectState) {
                          return DeviceListTile(
                            isLoading:
                                connectState
                                    is ConnectToBleDeviceLoadingState &&
                                connectState.index == index,
                            deviceName: device.advName,
                            deviceAddress: device.remoteId.toString(),
                            onPressed: () {
                              context
                                  .read<ConnectToBleDeviceCubit>()
                                  .connectToBleDevice(
                                    device: device,
                                    index: index,
                                  );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            }
            if (state is GetBleDevicesFailureState) {
              return Center(child: Text(state.message , style: Theme.of(context).textTheme.labelLarge,));
            }
            return const AppLoadingWidget();
          },
        ),
      ),
    );
  }
}
