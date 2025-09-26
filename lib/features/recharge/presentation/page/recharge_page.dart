import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/features/recharge/presentation/cubit/recharge_cubit.dart';

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
      appBar: AppBar(title: const Text("Recharge")),
      body: BlocListener<RechargeCubit, RechargeState>(
        listener: (context, state) {
          if (state is RechargeSuccessState) {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 126,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment(-1, 0),
                            child: Text(
                              "Recharge Successfull",
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment(-1, 0),
                            child: Text(
                              "Recharge Amount: ${_amountController.text}",
                            ),
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment(1, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.white,
                                  ),
                                  child: Text(
                                    "Cancel",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "OK",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
            _amountController.clear();
          }
          if (state is RechargeFailureState) {}
        },
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter Recharge Amount",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 40),
              TextField(
                cursorColor: AppColors.blue,
                controller: _amountController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  filled: false,
                  hintText: "₹0",
                  hintStyle: TextStyle(
                    fontSize: 50,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<RechargeCubit, RechargeState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: state is RechargeLoadingState ? null : () {},
            child: state is RechargeLoadingState
                ? Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: AppColors.blue,
                        strokeWidth: 5,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                  )
                : Icon(Icons.arrow_forward_ios_rounded, size: 18),
          );
        },
      ),
    );
  }
}
