import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/core/widgets/app_loading_widget.dart';
import 'package:telephone_recharge_application/features/recharge_history/presentation/cubit/get_recharge_history_cubit.dart';
import 'package:telephone_recharge_application/features/recharge_history/presentation/widgets/recharge_history_card.dart';

class RechargeHistoryPage extends StatefulWidget {
  const RechargeHistoryPage({super.key});

  @override
  State<RechargeHistoryPage> createState() => _RechargeHistoryPageState();
}

class _RechargeHistoryPageState extends State<RechargeHistoryPage> {
  @override
  void initState() {
    context.read<GetRechargeHistoryCubit>().getRechargeHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recharge History"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<GetRechargeHistoryCubit>().getRechargeHistory();
            },
            icon: Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: BlocBuilder<GetRechargeHistoryCubit, GetRechargeHistoryState>(
        builder: (context, state) {
          if (state is GetRechargeHistorySuccessState) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return RechargeHistoryCard(
                  title: "12-12-25",
                  subtitle: "9:30 AM",
                  trailing: "30",
                );
              },
              itemCount: 10,
            );
          }
          if (state is GetRechargeHistoryFailureState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            );
          }
          return AppLoadingWidget();
        },
      ),
    );
  }
}
