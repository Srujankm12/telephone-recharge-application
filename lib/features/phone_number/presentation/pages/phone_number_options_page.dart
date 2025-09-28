import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/features/phone_number/presentation/widgets/phone_number_option_card.dart';

class PhoneNumberOptionsPage extends StatelessWidget {
  const PhoneNumberOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Navigator.pushReplacementNamed(context, "/changePhoneNumbers");
              },
              cardText: "Update Numbers",
              cardIcon: Icons.change_circle_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
