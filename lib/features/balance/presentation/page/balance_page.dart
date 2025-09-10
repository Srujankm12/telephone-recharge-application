import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/features/balance/presentation/cubit/get_balance_cubit.dart';
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
  void initState() {
    context.read<GetBalanceCubit>().getBalance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Balance"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh_rounded)),
        ],
      ),
      body: BlocBuilder<GetBalanceCubit, GetBalanceState>(
        builder: (context, state) {
          if (state is GetBalanceSuccessState) {
            return BalanceSuccessWidget(amount: state.balance);
          }
          if (state is GetBalanceFailureState) {
            return BalanceFailureWidget();
          }
          return BalanceLoadingWidget();
        },
      ),
      bottomNavigationBar: BlocBuilder<GetBalanceCubit, GetBalanceState>(
        builder: (context, state) {
          if (state is GetBalanceSuccessState ||
              state is GetBalanceFailureState) {
            return SizedBox(
              height: 80,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state is GetBalanceSuccessState
                    ? () {
                        Navigator.pop(context);
                      }
                    : () {
                        context.read<GetBalanceCubit>().getBalance();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text(
                  state is GetBalanceSuccessState ? "Done" : "Try Again",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
