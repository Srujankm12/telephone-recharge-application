import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/features/initilize/presentation/widgets/card_mode_button.dart';

class CardModeListPage extends StatefulWidget {
  const CardModeListPage({super.key});

  @override
  State<CardModeListPage> createState() => _CardModeListPageState();
}

class _CardModeListPageState extends State<CardModeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mode's")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardModeButton(
              title: "Restricted",
              icon: Icons.call_end_rounded,
              onPressed: () {},
            ),
            SizedBox(height: 40),
            CardModeButton(
              title: "Free to Dial",
              icon: Icons.call_rounded,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
