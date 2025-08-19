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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ristricted Mode")),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Center(
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
                ),
                SizedBox(height: 20),
                RestrictedPhoneNumberTextField(
                  hintText: "Phone Number",
                  leading: Icons.phone_rounded,
                  onPressed: () {},
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
                      3,
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
                                  "8618245446",
                                  style: Theme.of(context).textTheme.labelLarge
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 4),
                                InkWell(
                                  onTap: () {
                                    // TODO: Delete Element
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
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {},
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
