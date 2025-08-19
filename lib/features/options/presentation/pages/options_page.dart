import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/features/options/presentation/widgets/options_big_card.dart';
import 'package:telephone_recharge_application/features/options/presentation/widgets/options_grid_card.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("VTELE009", style: Theme.of(context).textTheme.titleMedium),
            Text(
              "89:07:67:54:75",
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: AppColors.grey),
            ),
          ],
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            OptionsBigCard(),
            SizedBox(height: 10),
            GridView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: [
                OptionsGridCard(title: "Recharge", icon: Icons.currency_rupee_rounded,),
                OptionsGridCard(title: "Mode", icon: Icons.devices_rounded),
                OptionsGridCard(title: "Balance", icon: Icons.account_balance_rounded),
                OptionsGridCard(title: "History", icon: Icons.history_rounded),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
