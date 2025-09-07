import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/features/balance/presentation/widgets/balance_failure_widget.dart';
import 'package:telephone_recharge_application/features/balance/presentation/widgets/balance_loading_widget.dart';
import 'package:telephone_recharge_application/features/balance/presentation/widgets/balance_success_widget.dart';

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
            onPressed: () {

            }, 
            icon: Icon(
              Icons.refresh_rounded,
            ),
          ),
        ],
      ),
      body: BalanceLoadingWidget(),
      // bottomNavigationBar:  SizedBox(
      //     height: 80,
      //     width: double.infinity,
      //     child: ElevatedButton(
      //       onPressed: () {
              
      //       },
      //       style: ElevatedButton.styleFrom(
      //         backgroundColor: AppColors.blue,
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.zero,
      //         ),
      //       ),
      //       child: Text(
      //         "Done",
      //         style: Theme.of(context).textTheme.titleLarge?.copyWith(
      //           color: AppColors.white,
      //           fontWeight: FontWeight.w600,
      //         ),
      //       ),
      //     ),
      //   ),
    );
  }
}