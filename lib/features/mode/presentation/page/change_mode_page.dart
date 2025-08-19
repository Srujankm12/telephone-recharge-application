import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/features/mode/presentation/widgets/card_mode_switch_button.dart';
import 'package:telephone_recharge_application/features/mode/presentation/widgets/card_mode_widget.dart';

class ChangeModePage extends StatefulWidget {
  const ChangeModePage({super.key});

  @override
  State<ChangeModePage> createState() => _ChangeModePageState();
}

class _ChangeModePageState extends State<ChangeModePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Mode"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh_rounded)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                "Current Card Mode",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                "Your card mode",
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: AppColors.grey),
              ),
              SizedBox(height: 40),
              CardModeWidget(cardMode: 2),
              SizedBox(height: 40),
              CardModeSwitchButton(cardMode: 2),
            ],
          ),
        ),
      ),
    );
  }
}
