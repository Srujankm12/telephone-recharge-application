import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class DeviceListTile extends StatefulWidget {
  final String deviceName;
  final String deviceAddress;
  final VoidCallback onPressed;
  const DeviceListTile({
    super.key,
    required this.deviceName,
    required this.deviceAddress,
    required this.onPressed,
  });

  @override
  State<DeviceListTile> createState() => _DeviceListTileState();
}

class _DeviceListTileState extends State<DeviceListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.opacBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.bluetooth_rounded, color: AppColors.blue),
      ),
      title: Text(
        widget.deviceName,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        widget.deviceAddress,
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(color: AppColors.grey),
      ),
      onTap: widget.onPressed,
    );
  }
}
