import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class CardModeSwitchButton extends StatelessWidget {
  final int cardMode;
  const CardModeSwitchButton({super.key, required this.cardMode});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 280,
      child: Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                cardMode == 1 ? Icons.call_rounded : Icons.call_end_rounded,
                size: 50,
                color: AppColors.blue,
              ),
              SizedBox(height: 10),
              Text(
                cardMode == 1
                    ? "Switch to Free to Dial"
                    : "Switch to Restricted Mode",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
