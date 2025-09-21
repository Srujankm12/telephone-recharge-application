import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class PhoneNumberCard extends StatelessWidget {
  final String phoneNumber;
  final VoidCallback onPressed;
  const PhoneNumberCard({
    super.key,
    required this.phoneNumber,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white,
          border: Border.all(color: AppColors.opacBlue),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                phoneNumber,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 4),
              InkWell(
                onTap: onPressed,
                child: Icon(Icons.close_rounded, color: AppColors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
