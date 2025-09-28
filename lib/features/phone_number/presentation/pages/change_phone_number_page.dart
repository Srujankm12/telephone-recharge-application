import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/core/widgets/app_snackbar.dart';
import 'package:telephone_recharge_application/features/phone_number/presentation/cubit/add_phone_numbers_cubit.dart';
import 'package:telephone_recharge_application/features/phone_number/presentation/cubit/get_phone_number_cubit.dart';
import 'package:telephone_recharge_application/features/phone_number/presentation/widgets/phone_number_card.dart';
import 'package:telephone_recharge_application/features/phone_number/presentation/widgets/phone_number_submit_button.dart';
import 'package:telephone_recharge_application/features/phone_number/presentation/widgets/phone_number_text_field.dart';

class ChangePhoneNumberPage extends StatefulWidget {
  const ChangePhoneNumberPage({super.key});

  @override
  State<ChangePhoneNumberPage> createState() => _ChangePhoneNumberPageState();
}

class _ChangePhoneNumberPageState extends State<ChangePhoneNumberPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final List<String> _phoneNumbers = [];

  void _getExistingPhoneNumbers() {
    BlocProvider.of<GetPhoneNumberCubit>(context).getPhoneNumbers();
  }

  void _addPhoneNumbersToList({required String phoneNumber}) {
    setState(() {
      _phoneNumbers.add(phoneNumber);
    });
  }

  void _removePhoneNumberFromList({required int index}) {
    setState(() {
      _phoneNumbers.removeAt(index);
    });
  }

  String? _phoneNumberValidator(String? phoneNumber) {
    if (phoneNumber!.length < 10) return "Enter a Valid Phone Number";
    return null;
  }

  void _clearPhoneNumberTextField() {
    _phoneNumberController.clear();
  }

  @override
  void initState() {
    super.initState();
    _getExistingPhoneNumbers();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetPhoneNumberCubit, GetPhoneNumberState>(
          listener: (context, state) {
            if (state is GetPhoneNumbersSuccessState) {
              setState(() {
                _phoneNumbers.addAll(state.phoneNumbers);
              });
            }
            if (state is GetPhoneNumbersFailureState) {
              AppSnackbar.showSnackBar(state.message, context);
              Navigator.pop(context);
            }
          },
        ),
        BlocListener<AddPhoneNumbersCubit, AddPhoneNumbersState>(
          listener: (context, state) {
            if (state is AddPhoneNumbersSuccessState) {
              AppSnackbar.showSnackBar(state.message, context);
              Navigator.pop(context);
            }
            if (state is AddPhoneNumbersFailureState) {
              AppSnackbar.showSnackBar(state.message, context);
              Navigator.pop(context);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text("Add Phone Number")),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Enter the Phone Numbers Below.",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Please Enter 3 Valid Phone Numbers.",
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(color: AppColors.grey),
                    ),
                    SizedBox(height: 20),
                    PhoneNumberTextField(
                      hintText: "Phone Number",
                      leading: Icons.phone_iphone_rounded,
                      onPressed: _phoneNumbers.length == 3
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                _addPhoneNumbersToList(
                                  phoneNumber: _phoneNumberController.text,
                                );
                                _clearPhoneNumberTextField();
                              }
                            },
                      validator: _phoneNumberValidator,
                      controller: _phoneNumberController,
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment(-1, 0),
                      child: Text(
                        "Phone Numbers",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment(-1, 0),
                      child: Wrap(
                        children: List.generate(_phoneNumbers.length, (index) {
                          return PhoneNumberCard(
                            phoneNumber: _phoneNumbers[index],
                            onPressed: () {
                              _removePhoneNumberFromList(index: index);
                            },
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomSheet: BlocBuilder<AddPhoneNumbersCubit, AddPhoneNumbersState>(
          builder: (context, state) {
            return PhoneNumberSubmitButton(
              isLoading: state is AddPhoneNumbersLoadingState,
              onPressed: _phoneNumbers.length == 3
                  ? () {
                      context.read<AddPhoneNumbersCubit>().addPhoneNumbers(
                        signal: "9",
                        phoneNumbers: _phoneNumbers,
                      );
                    }
                  : null,
            );
          },
        ),
      ),
    );
  }
}
