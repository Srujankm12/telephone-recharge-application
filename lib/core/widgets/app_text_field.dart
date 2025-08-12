import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class AppTextField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool isPasswordField;
  final String? Function(String?)? validator;
  const AppTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPasswordField = false,
    this.validator,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      cursorColor: AppColors.grey,
      cursorHeight: 14,
      cursorOpacityAnimates: true,
      cursorRadius: Radius.circular(10),
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(widget.icon),
        suffixIcon: widget.isPasswordField
            ? isObscure
                  ? IconButton(
                      icon: Icon(Icons.remove_red_eye_rounded),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.visibility_off_rounded),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                    )
            : null,
      ),
    );
  }
}
