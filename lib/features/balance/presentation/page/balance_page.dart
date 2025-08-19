import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Balance"),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(
              Icons.refresh_rounded,
            ),
          ),
        ],
      ),
      body: Center(
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
      ),
      bottomNavigationBar:  SizedBox(
          height: 80, // Full height of bottom area
          width: double.infinity, // Full width
          child: ElevatedButton(
            onPressed: () {
              
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blue, // PhonePe purple
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // No rounded corners, covers whole area
              ),
            ),
            child: Text(
              "Done",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
    );
  }
}