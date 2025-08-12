import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
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
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.opacBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.bluetooth_rounded, color: AppColors.white),
            ),
            title: Text(
              "Vithsutra Bluetooth",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              "80:5C:9T:91:7D",
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: AppColors.grey),
            ),
            onTap: () {},
          );
        },
        itemCount: 20,
      ),
    );
  }
}
