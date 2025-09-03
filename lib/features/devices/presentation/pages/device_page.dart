import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/core/widgets/app_loading_widget.dart';
import 'package:telephone_recharge_application/features/devices/presentation/cubit/connect_to_ble_device_cubit.dart';
import 'package:telephone_recharge_application/features/devices/presentation/cubit/get_ble_devices_cubit.dart';
import 'package:telephone_recharge_application/features/devices/presentation/widgets/device_list_tile.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  @override
  void initState() {
    BlocProvider.of<GetBleDevicesCubit>(context).getBleDevices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectToBleDeviceCubit, ConnectToBleDeviceState>(
      listener: (context, state) {
        if (state is ConnectToBleDeviceSuccessState &&
            state.connectionStatus == true) {
          Navigator.pushNamed(context, "/options");
        }
        if (state is ConnectToBleDeviceSuccessState &&
            state.connectionStatus == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              elevation: 0,
              content: Text(
                "Failed to Connect.",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: AppColors.white),
              ),
              backgroundColor: AppColors.blue,
            ),
          );
        }
        if (state is ConnectToBleDeviceFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              elevation: 0,
              content: Text(
                state.message,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: AppColors.white),
              ),
              backgroundColor: AppColors.blue,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          leading: Icon(Icons.bluetooth_audio_rounded),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Device's", style: Theme.of(context).textTheme.titleLarge),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Scanning for Device's",
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(color: AppColors.grey),
                  ),
                  SizedBox(width: 5),
                  SizedBox(
                    width: 5.5,
                    height: 5.5,
                    child: CircularProgressIndicator(
                      color: AppColors.grey,
                      strokeCap: StrokeCap.round,
                      strokeWidth: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                BlocProvider.of<GetBleDevicesCubit>(context).getBleDevices();
              },
              icon: Icon(Icons.refresh_rounded),
            ),
          ],
        ),
        body: BlocBuilder<GetBleDevicesCubit, GetBleDevicesState>(
          builder: (context, state) {
            if (state is GetBleDevicesSuccessState) {
              return StreamBuilder(
                stream: state.devices,
                builder: (context, asyncSnapshot) {
                  if (!asyncSnapshot.hasData) {
                    return AppLoadingWidget();
                  }
                  final devices = asyncSnapshot.data;
                  return ListView.builder(
                    itemCount: devices?.length,
                    itemBuilder: (context, index) {
                      final device = devices?[index].device;
                      if (device!.advName.startsWith("TEL")) {
                        return BlocBuilder<
                          ConnectToBleDeviceCubit,
                          ConnectToBleDeviceState
                        >(
                          builder: (context, state) {
                            return DeviceListTile(
                              isLoading:
                                  state is ConnectToBleDeviceLoadingState &&
                                  state.index == index,
                              deviceName: device.advName,
                              deviceAddress: device.remoteId.toString(),
                              onPressed: () {
                                BlocProvider.of<ConnectToBleDeviceCubit>(
                                  context,
                                ).connectToBleDevice(
                                  device: device,
                                  index: index,
                                );
                              },
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  );
                },
              );
            }
            if (state is GetBleDevicesFailureState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text(state.message)],
                ),
              );
            }
            return AppLoadingWidget();
          },
        ),
      ),
    );
  }
}
