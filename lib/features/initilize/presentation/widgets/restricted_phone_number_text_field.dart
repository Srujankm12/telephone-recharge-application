import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class RestrictedPhoneNumberTextField extends StatelessWidget {
  final String hintText;
  final IconData leading;
  final VoidCallback onPressed;
  const RestrictedPhoneNumberTextField({
    super.key,
    required this.hintText,
    required this.leading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      autocorrect: true,
      cursorColor: AppColors.grey,
      cursorHeight: 14,
      cursorOpacityAnimates: true,
      cursorRadius: Radius.circular(10),
      decoration: InputDecoration(
        prefixIcon: Icon(leading),
        hintText: hintText,
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.add_rounded, color: AppColors.blue),
        ),
      ),
    );
  }
}
