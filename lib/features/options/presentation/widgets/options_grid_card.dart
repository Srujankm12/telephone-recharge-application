import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class OptionsGridCard extends StatelessWidget {
  final String title;
  final IconData icon;
  const OptionsGridCard({super.key , required this.title , required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          color: AppColors.blue,
                          size: 50,
                        ),
                        SizedBox(height: 5),
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                );
  }
}