import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
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
                  title: state.rechargeHistory[index].date,
                  subtitle: state.rechargeHistory[index].time,
                  trailing: state.rechargeHistory[index].rechargeAmount,
                );
              },
              itemCount: state.rechargeHistory.length,
            );
          }
          if (state is GetRechargeHistoryFailureState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.no_accounts_rounded, size: 80),
                  SizedBox(height: 5),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Try Again",
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: AppColors.grey),
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
