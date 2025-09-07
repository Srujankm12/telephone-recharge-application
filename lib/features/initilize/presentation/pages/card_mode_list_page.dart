import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/arguments/options_page_args.dart';
import 'package:telephone_recharge_application/features/initilize/presentation/widgets/card_mode_button.dart';

class CardModeListPage extends StatefulWidget {
  final OptionsPageArgs args;
  const CardModeListPage({super.key, required this.args});

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
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  "/restrictedModeInitilizationPage",
                  arguments: widget.args,
                );
              },
            ),
            SizedBox(height: 40),
            CardModeButton(
              title: "Free to Dial",
              icon: Icons.call_rounded,
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  "/freeToDialModeInitilizationPage",
                  arguments: widget.args,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
