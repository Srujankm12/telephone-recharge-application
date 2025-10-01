import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class CardModeWidget extends StatelessWidget {
  final String cardMode;
  const CardModeWidget({super.key, required this.cardMode});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          cardMode == "1" ? Icons.call_end_rounded : Icons.call_rounded,
          size: 50,
          color: AppColors.blue,
        ),
        SizedBox(height: 5),
        Text(
          cardMode == "1" ? "Restricted" : "Free to Dial",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(color: AppColors.blue),
        ),
      ],
    );
  }
}
