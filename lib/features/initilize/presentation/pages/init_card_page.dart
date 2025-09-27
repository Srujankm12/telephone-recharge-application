import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/core/widgets/app_snackbar.dart';
import 'package:telephone_recharge_application/core/widgets/app_text_field.dart';
import 'package:telephone_recharge_application/features/initilize/presentation/cubit/init_card_cubit.dart';
import 'package:telephone_recharge_application/features/initilize/presentation/widgets/initilize_button.dart';
import 'package:telephone_recharge_application/features/initilize/presentation/widgets/radio_buttons.dart';

class InitCardPage extends StatefulWidget {
  const InitCardPage({super.key});

  @override
  State<InitCardPage> createState() => _InitCardPageState();
}

class _InitCardPageState extends State<InitCardPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  String _cardMode = "1";

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InitCardCubit, InitCardState>(
      listener: (context, state) {
        if (state is InitCardSuccessState) {
          AppSnackbar.showSnackBar(state.message, context);
          Navigator.pop(context);
        }
        if (state is InitCardFailureState) {
          AppSnackbar.showSnackBar(state.message, context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Card Initilization")),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Enter Initial Recharge Amount",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "This amount is for initial card balance.",
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(color: AppColors.grey),
                    ),
                    SizedBox(height: 20),
                    AppTextField(
                      hintText: "Amount",
                      icon: Icons.currency_rupee_rounded,
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter the Amount.";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    RadioButtons(
                      selectedValue: _cardMode,
                      onChanged: (val) {
                        setState(() {
                          _cardMode = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomSheet: BlocBuilder<InitCardCubit, InitCardState>(
          builder: (context, state) {
            return InitilizeButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<InitCardCubit>().initCard(
                    signal: "2",
                    mode: _cardMode,
                    amount: _amountController.text,
                  );
                }
              },
              isLoading: state is IntiCardLoadingState,
            );
          },
        ),
      ),
    );
  }
}
