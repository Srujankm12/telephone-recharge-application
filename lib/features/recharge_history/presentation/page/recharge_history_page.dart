import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/features/recharge_history/presentation/widgets/recharge_history_card.dart';

class RechargeHistoryPage extends StatefulWidget {
  const RechargeHistoryPage({super.key});

  @override
  State<RechargeHistoryPage> createState() => _RechargeHistoryPageState();
}

class _RechargeHistoryPageState extends State<RechargeHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recharge History"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh_rounded))
        ],
      ),
      body: ListView.builder(itemBuilder: (context,index) {
        return RechargeHistoryCard(title: "12-12-25", subtitle: "9:30 AM", trailing: "30");
      } , itemCount: 10,),
    );
  }
}