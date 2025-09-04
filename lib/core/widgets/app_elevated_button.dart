import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class AppElevatedButton extends StatefulWidget {
  final String buttonText;
  final bool isLoading;
  final VoidCallback onPressed;
  const AppElevatedButton({
    super.key, 
    required this.buttonText, 
    this.isLoading = false,
    required this.onPressed,
  });

  @override
  State<AppElevatedButton> createState() => _AppElevatedButtonState();
}

class _AppElevatedButtonState extends State<AppElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width, 50),
      ),
      child: widget.isLoading ? Center(child: SizedBox(width: 20 , height: 20,child: CircularProgressIndicator(
        color: AppColors.white,
        strokeCap: StrokeCap.round,
        strokeWidth: 2,
      ),),): Text(
        widget.buttonText,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
