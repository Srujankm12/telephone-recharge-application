import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/core/arguments/options_page_args.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/core/widgets/app_snackbar.dart';
import 'package:telephone_recharge_application/core/widgets/app_text_field.dart';
import 'package:telephone_recharge_application/features/initilize/presentation/widgets/initilize_button.dart';

class FreeToDialModeInitilizationPage extends StatefulWidget {
  final OptionsPageArgs args;
  const FreeToDialModeInitilizationPage({super.key, required this.args});

  @override
  State<FreeToDialModeInitilizationPage> createState() =>
      _FreeToDialModeInitilizationPageState();
}

class _FreeToDialModeInitilizationPageState
    extends State<FreeToDialModeInitilizationPage> {
  final TextEditingController _amountController = TextEditingController();
  final _forkKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  String? amountValidator(String? value) {
    final RegExp amountRegex = RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d{1,2})?$');
    if (value == null || value.trim().isEmpty) {
      return 'Please enter an amount';
    }
    if (!amountRegex.hasMatch(value)) {
      return 'Enter a valid amount';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InitCardFreeToDialCubit, InitCardFreeToDialState>(
      listener: (context, state) {
        if (state is InitCardFreeToDialSuccessState) {
          AppSnackbar.showSnackBar(state.message, context);
        }
        if (state is InitCardFreeToDialFailureState) {
          AppSnackbar.showSnackBar(state.message, context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Free to Dial Mode")),
        body: SingleChildScrollView(
          child: Form(
            key: _forkKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Enter the Amount Below",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      "Your Amount below",
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(color: AppColors.grey),
                    ),
                    SizedBox(height: 20),
                    AppTextField(
                      hintText: "Amount",
                      icon: Icons.currency_rupee_rounded,
                      controller: _amountController,
                      validator: amountValidator,
                      keyboardType: TextInputType.number,
                      onChanged: (p0) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomSheet:
            BlocBuilder<InitCardFreeToDialCubit, InitCardFreeToDialState>(
              builder: (context, state) {
                return InitilizeButton(
                  isButtonEnabled: _amountController.text.isNotEmpty,
                  isLoading: state is InitCardFreeToDialLoadingState,
                  onPressed: () {
                    if (_forkKey.currentState!.validate()) {
                      context
                          .read<InitCardFreeToDialCubit>()
                          .initCardFreeToDial(amount: _amountController.text);
                    }
                  },
                );
              },
            ),
      ),
    );
  }
}
