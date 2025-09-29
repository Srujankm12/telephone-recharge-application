import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/features/phone_number/presentation/cubit/check_card_mode_cubit.dart';
import 'package:telephone_recharge_application/features/phone_number/presentation/widgets/phone_number_option_card.dart';

class PhoneNumberOptionsPage extends StatefulWidget {
  const PhoneNumberOptionsPage({super.key});

  @override
  State<PhoneNumberOptionsPage> createState() => _PhoneNumberOptionsPageState();
}

class _PhoneNumberOptionsPageState extends State<PhoneNumberOptionsPage> {
  @override
  void initState() {
    context.read<CheckCardModeCubit>().checkCardMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckCardModeCubit, CheckCardModeState>(
      listener: (context, state) {
        if (state is CheckCardModeFailureState) {
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
                                  style: Theme.of(context).textTheme.labelLarge
                                      ?.copyWith(fontWeight: FontWeight.w600),
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
                                  style: Theme.of(context).textTheme.labelLarge
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
      child: Scaffold(
        appBar: AppBar(title: Text("Update Phone Number")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PhoneNumberOptionCard(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/addPhoneNumbers");
                },
                cardText: "Add New Numbers",
                cardIcon: Icons.add_card_rounded,
              ),
              SizedBox(height: 40),
              PhoneNumberOptionCard(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    "/changePhoneNumbers",
                  );
                },
                cardText: "Update Numbers",
                cardIcon: Icons.change_circle_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
