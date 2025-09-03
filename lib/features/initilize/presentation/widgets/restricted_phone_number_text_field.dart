import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class RestrictedPhoneNumberTextField extends StatelessWidget {
  final String hintText;
  final IconData leading;
  final VoidCallback? onPressed;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const RestrictedPhoneNumberTextField({
    super.key,
    required this.hintText,
    required this.leading,
    required this.onPressed,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      maxLength: 10,
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
          icon: onPressed != null
              ? Icon(Icons.add_rounded, color: AppColors.blue)
              : Icon(Icons.add_rounded, color: AppColors.grey),
        ),
      ),
    );
  }
}
