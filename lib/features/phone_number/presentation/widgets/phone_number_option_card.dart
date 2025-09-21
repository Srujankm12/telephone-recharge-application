import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class PhoneNumberOptionCard extends StatelessWidget {
  final VoidCallback? onPressed;
  final String cardText;
  final IconData cardIcon;
  const PhoneNumberOptionCard({
    super.key,
    required this.onPressed,
    required this.cardText,
    required this.cardIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(cardIcon, color: AppColors.blue, size: 50),
              SizedBox(height: 5),
              Text(cardText, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
