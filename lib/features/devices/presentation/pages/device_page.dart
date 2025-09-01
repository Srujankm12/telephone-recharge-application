import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/core/utils/telephone_bluetooth_manager.dart';
import 'package:telephone_recharge_application/features/devices/presentation/cubit/get_ble_devices_cubit.dart';
import 'package:telephone_recharge_application/features/devices/presentation/widgets/device_list_tile.dart';
import 'package:telephone_recharge_application/init_dependencies.dart';

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
    return Scaffold(
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
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh_rounded)),
        ],
      ),
      body: BlocBuilder<GetBleDevicesCubit, GetBleDevicesState>(
        builder: (context, state) {
          if (state is GetBleDevicesSuccessState) {
            return StreamBuilder(
              stream: state.devices,
              builder: (context, asyncSnapshot) {
                if (!asyncSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final devices = asyncSnapshot.data;

                return ListView.builder(
                  itemCount: devices.,
                  itemBuilder: (context, index) {
                    final device = devices[index].device;
                    return DeviceListTile(
                      deviceName: device.advName,
                      deviceAddress: device.remoteId.toString(),
                      onPressed: () {},
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
