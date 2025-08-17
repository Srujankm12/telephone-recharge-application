import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class RechargePage extends StatefulWidget {
  const RechargePage({super.key});

  @override
  State<RechargePage> createState() => _RechargePageState();
}

class _RechargePageState extends State<RechargePage> {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recharge"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter Recharge Amount",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              "VTELE001",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.grey,
                  ),
            ),
            const SizedBox(height: 40),
            TextField(
              cursorColor: AppColors.blue,
              controller: _amountController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 50, // big font like GPay
                fontWeight: FontWeight.w500,
              ),
              decoration: const InputDecoration(
                filled: false,
                hintText: "₹0", // placeholder like GPay
                hintStyle: TextStyle(
                  fontSize: 50,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none, // no border
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){} , child: Icon(Icons.arrow_forward_ios_rounded , size: 18,),),
    );
  }
}
