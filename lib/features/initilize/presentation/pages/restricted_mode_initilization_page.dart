import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/core/widgets/app_text_field.dart';
import 'package:telephone_recharge_application/features/initilize/presentation/widgets/restricted_phone_number_text_field.dart';

class RestrictedModeInitilizationPage extends StatefulWidget {
  const RestrictedModeInitilizationPage({super.key});

  @override
  State<RestrictedModeInitilizationPage> createState() =>
      _RestrictedModeInitilizationPageState();
}

class _RestrictedModeInitilizationPageState
    extends State<RestrictedModeInitilizationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final List<String> phoneNumbers = [];

  void _addPhoneNumberToList(String phoneNumber) {
    setState(() {
      phoneNumbers.add(phoneNumber);
    });
    _phoneNumberController.clear();
  }

  void _removePhoneNumberFromList(int index) {
    setState(() {
      phoneNumbers.removeAt(index);
    });
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ristricted Mode")),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Enter the Details Below",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    "Your details below",
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: AppColors.grey),
                  ),
                  SizedBox(height: 20),
                  AppTextField(
                    hintText: "Amount",
                    icon: Icons.currency_rupee_rounded,
                    controller: _amountController,
                  ),
                  SizedBox(height: 20),
                  RestrictedPhoneNumberTextField(
                    hintText: "Phone Number",
                    leading: Icons.phone_rounded,
                    onPressed: phoneNumbers.length != 3
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              _addPhoneNumberToList(
                                _phoneNumberController.text,
                              );
                            }
                          }
                        : null,
                    controller: _phoneNumberController,
                    validator: (value) {
                      if (value?.length != 10) {
                        return "Enter a valid Phone Number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment(-1, 0),
                    child: Text(
                      "Phone Numbers",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment(-1, 0),
                    child: Wrap(
                      children: List.generate(
                        phoneNumbers.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.white,
                              border: Border.all(color: AppColors.opacBlue),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    phoneNumbers[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(width: 4),
                                  InkWell(
                                    onTap: () {
                                      _removePhoneNumberFromList(index);
                                    },
                                    child: Icon(
                                      Icons.close_rounded,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
        child: ElevatedButton(
          onPressed: phoneNumbers.length == 3 ? () {} : null,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            fixedSize: Size(MediaQuery.of(context).size.width, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
          child: Text(
            "Initilize Card",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
