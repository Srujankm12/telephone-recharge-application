import 'package:flutter/material.dart';

class RechargeSuccessPage extends StatefulWidget {
  const RechargeSuccessPage({super.key});

  @override
  State<RechargeSuccessPage> createState() => _RechargeSuccessPageState();
}

class _RechargeSuccessPageState extends State<RechargeSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              "Recharge Successfull.",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
