import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/core/widgets/app_loading_widget.dart';
import 'package:telephone_recharge_application/core/widgets/app_snackbar.dart';
import 'package:telephone_recharge_application/features/mode/presentation/cubit/change_card_mode_cubit.dart';
import 'package:telephone_recharge_application/features/mode/presentation/cubit/get_card_mode_cubit.dart';
import 'package:telephone_recharge_application/features/mode/presentation/widgets/card_mode_switch_button.dart';
import 'package:telephone_recharge_application/features/mode/presentation/widgets/card_mode_widget.dart';

class ChangeModePage extends StatefulWidget {
  const ChangeModePage({super.key});

  @override
  State<ChangeModePage> createState() => _ChangeModePageState();
}

class _ChangeModePageState extends State<ChangeModePage> {
  @override
  void initState() {
    context.read<GetCardModeCubit>().checkCardMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetCardModeCubit, GetCardModeState>(
          listener: (context, state) {
            if (state is GetCardModeFailureState) {
              showDialog(
                barrierDismissible: false,
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
                                "Invalid Mode",
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment(-1, 0),
                              child: Text(state.message),
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
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
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
            }
          },
        ),
        BlocListener<ChangeCardModeCubit, ChangeCardModeState>(
          listener: (context, state) {
            if (state is ChangeCardModeSuccessState) {
              AppSnackbar.showSnackBar(state.message, context);
              Navigator.pop(context);
            }
            if (state is ChangeCardModeFailureState) {
              AppSnackbar.showSnackBar(state.message, context);
              Navigator.pop(context);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text("Change Mode")),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: BlocBuilder<GetCardModeCubit, GetCardModeState>(
              builder: (context, state) {
                if (state is GetCardModeLoadingState) {
                  return AppLoadingWidget();
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Present Card Mode",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      "Your card mode",
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(color: AppColors.grey),
                    ),
                    SizedBox(height: 40),
                    BlocBuilder<GetCardModeCubit, GetCardModeState>(
                      builder: (context, state) {
                        if (state is GetCardModeSuccessState) {
                          return CardModeWidget(cardMode: state.cardMode);
                        }
                        return Container();
                      },
                    ),
                    SizedBox(height: 40),
                    BlocBuilder<GetCardModeCubit, GetCardModeState>(
                      builder: (context, state) {
                        if (state is GetCardModeSuccessState) {
                          return CardModeSwitchButton(
                            cardMode: state.cardMode,
                            isLoading: state is ChangeCardModeLoadingState,
                            onPressed: () {
                              context
                                  .read<ChangeCardModeCubit>()
                                  .changeCardMode(
                                    signal: "8",
                                    mode: state.cardMode == "1" ? "2" : "1",
                                  );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
