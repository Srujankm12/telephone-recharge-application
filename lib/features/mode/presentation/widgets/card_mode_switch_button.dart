import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class CardModeSwitchButton extends StatelessWidget {
  final String cardMode;
  final VoidCallback onPressed;
  final bool isLoading;
  const CardModeSwitchButton({
    super.key,
    required this.cardMode,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 280,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: Card(
          child: Center(
            child: !isLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        cardMode == "2"
                            ? Icons.call_rounded
                            : Icons.call_end_rounded,
                        size: 50,
                        color: AppColors.blue,
                      ),
                      SizedBox(height: 10),
                      Text(
                        cardMode == "2"
                            ? "Switch to Free to Dial"
                            : "Switch to Restricted Mode",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  )
                : CircularProgressIndicator(
                    color: AppColors.blue,
                    strokeCap: StrokeCap.round,
                    strokeWidth: 2,
                  ),
          ),
        ),
      ),
    );
  }
}
