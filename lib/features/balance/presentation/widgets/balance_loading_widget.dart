import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class BalanceLoadingWidget extends StatelessWidget {
  const BalanceLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 180,
            height: 180,
            child: CircularProgressIndicator(
              color: AppColors.blue,
              strokeWidth: 15,
              strokeCap: StrokeCap.round,
            ),
          ),
          SizedBox(height: 30,),
          Text("Fetching Card Balance" , style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),),
          SizedBox(height: 5,),
          Text("Processing..." , style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.grey,
          ),)
        ],
      ),
    );
  }
}