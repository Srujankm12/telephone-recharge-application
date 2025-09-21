import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class BalanceFailureWidget extends StatelessWidget {
  final String message;
  const BalanceFailureWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Icon(Icons.close_rounded, size: 80, color: AppColors.red),
          SizedBox(height: 20),
          Text(
            "Balance Checking Failed",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            message,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: AppColors.grey),
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}
