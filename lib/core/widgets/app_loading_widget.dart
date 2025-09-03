import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: AppColors.blue,
              strokeCap: StrokeCap.round,
              strokeWidth: 2,
            ),
          ),
          SizedBox(height: 10),
          Text("Loading", style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}
