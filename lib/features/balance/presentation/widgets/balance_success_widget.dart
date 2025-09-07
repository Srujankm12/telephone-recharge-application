import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class BalanceSuccessWidget extends StatelessWidget {
  const BalanceSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Icon(
              Icons.done_rounded, 
              size: 80,
              color: AppColors.green,
            ),
            SizedBox(height: 20,),
            Text("Balance Checked Successfully" , style: Theme.of(context).textTheme.headlineSmall,),
            Text(
            "Your Card Balance", 
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.grey,
              ),
            ),
            SizedBox(height: 80,),
            Text("₹100.00" , style: Theme.of(context).textTheme.headlineLarge,)
          ],
        ),
      );
  }
}