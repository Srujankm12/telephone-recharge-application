import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/features/phone_number/presentation/widgets/phone_number_card.dart';
import 'package:telephone_recharge_application/features/phone_number/presentation/widgets/phone_number_submit_button.dart';
import 'package:telephone_recharge_application/features/phone_number/presentation/widgets/phone_number_text_field.dart';

class AddPhoneNumberPage extends StatefulWidget {
  const AddPhoneNumberPage({super.key});

  @override
  State<AddPhoneNumberPage> createState() => _AddPhoneNumberPageState();
}

class _AddPhoneNumberPageState extends State<AddPhoneNumberPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final List<String> _phoneNumbers = [];

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
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Phone Number")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Enter the Phone Numbers Below.",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 5),
                  Text("Please Enter 3 Valid Phone Numbers."),
                  SizedBox(height: 15),
                  PhoneNumberTextField(
                    hintText: "Phone Number",
                    leading: Icons.phone_iphone_rounded,
                    onPressed: () {
                      _addPhoneNumbersToList(
                        phoneNumber: _phoneNumberController.text,
                      );
                      _clearPhoneNumberTextField();
                    },
                    validator: _phoneNumberValidator,
                    controller: _phoneNumberController,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Phone Numbers",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
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
      bottomSheet: PhoneNumberSubmitButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {}
        },
      ),
    );
  }
}
