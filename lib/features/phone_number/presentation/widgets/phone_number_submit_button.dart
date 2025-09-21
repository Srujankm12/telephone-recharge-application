import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class PhoneNumberSubmitButton extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  const PhoneNumberSubmitButton({
    super.key,
    this.isLoading = false,
    required this.onPressed,
  });

  @override
  State<PhoneNumberSubmitButton> createState() =>
      _PhoneNumberSubmitButtonState();
}

class _PhoneNumberSubmitButtonState extends State<PhoneNumberSubmitButton> {
  Widget _buttonWidget(bool isLoading) {
    if (isLoading) {
      return Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeCap: StrokeCap.round,
            color: AppColors.white,
            strokeWidth: 3,
          ),
        ),
      );
    }
    return Text("Submit", style: Theme.of(context).textTheme.titleLarge);
  }

  VoidCallback? _buttonState(VoidCallback? callback) {
    if (callback == null) return null;
    return callback;
  }

  ButtonStyle? _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.blue,
      fixedSize: Size(MediaQuery.of(context).size.width, 40),
      foregroundColor: AppColors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ElevatedButton(
        onPressed: _buttonState(widget.onPressed),
        style: _buttonStyle(),
        child: _buttonWidget(widget.isLoading),
      ),
    );
  }
}
