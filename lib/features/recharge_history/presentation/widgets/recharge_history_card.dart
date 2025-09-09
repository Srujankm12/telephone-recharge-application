import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class RechargeHistoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String trailing;
  const RechargeHistoryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(
        subtitle,
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(color: AppColors.grey),
      ),
      trailing: Text(
        "- $trailing",
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: AppColors.red,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.opacBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.history, color: AppColors.blue),
      ),
    );
  }
}
