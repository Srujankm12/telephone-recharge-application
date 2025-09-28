import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/arguments/options_page_args.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/features/options/presentation/widgets/options_big_card.dart';
import 'package:telephone_recharge_application/features/options/presentation/widgets/options_grid_card.dart';

class OptionsPage extends StatefulWidget {
  final OptionsPageArgs args;
  const OptionsPage({super.key, required this.args});

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
            Text(
              widget.args.device.advName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              widget.args.device.remoteId.toString(),
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: AppColors.grey),
            ),
          ],
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              OptionsBigCard(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    "/initCardMode",
                    arguments: OptionsPageArgs(device: widget.args.device),
                  );
                },
              ),
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
                  OptionsGridCard(
                    title: "Recharge",
                    icon: Icons.currency_rupee_rounded,
                    onPressed: () {
                      Navigator.pushNamed(context, "/recharge");
                    },
                  ),
                  OptionsGridCard(
                    title: "Mode",
                    icon: Icons.devices_rounded,
                    onPressed: () {
                      Navigator.pushNamed(context, "/changeMode");
                    },
                  ),
                  OptionsGridCard(
                    title: "Balance",
                    icon: Icons.account_balance_rounded,
                    onPressed: () {
                      Navigator.pushNamed(context, "/balance");
                    },
                  ),
                  OptionsGridCard(
                    title: "History",
                    icon: Icons.history_rounded,
                    onPressed: () {
                      Navigator.pushNamed(context, "/history");
                    },
                  ),
                  OptionsGridCard(
                    title: "Phone Number",
                    icon: Icons.phone_rounded,
                    onPressed: () {
                      Navigator.pushNamed(context, "/phoneNumberOptions");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
