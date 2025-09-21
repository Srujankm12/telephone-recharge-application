import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/widgets/app_text_field.dart';
import 'package:telephone_recharge_application/features/initilize/presentation/widgets/initilize_button.dart';
import 'package:telephone_recharge_application/features/initilize/presentation/widgets/radio_buttons.dart';

class InitCardPage extends StatefulWidget {
  const InitCardPage({super.key});

  @override
  State<InitCardPage> createState() => _InitCardPageState();
}

class _InitCardPageState extends State<InitCardPage> {
  final TextEditingController _amountController = TextEditingController();
  String _cardMode = "1";

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Card Initilization")),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  "Enter Initial Recharge Amount",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 5),
                Text("This amount is for initial card balance."),
                SizedBox(height: 10),
                AppTextField(
                  hintText: "Amount",
                  icon: Icons.currency_rupee_rounded,
                  controller: _amountController,
                ),
                SizedBox(height: 10),
                RadioButtons(
                  selectedValue: _cardMode,
                  onChanged: (val) {
                    _cardMode = val;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: InitilizeButton(onPressed: () {}),
    );
  }
}
