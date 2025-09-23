import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';

class InitilizeButton extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  const InitilizeButton({
    super.key,
    this.isLoading = false,
    required this.onPressed,
  });

  @override
  State<InitilizeButton> createState() => _InitilizeButtonState();
}

class _InitilizeButtonState extends State<InitilizeButton> {
  Widget _buttonWidget(bool isLoading) {
    if (isLoading) {
      return Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeCap: StrokeCap.round,
            color: AppColors.blue,
            strokeWidth: 3,
          ),
        ),
      );
    }
    return Text(
      "Initilize",
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: AppColors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  VoidCallback? _buttonState(VoidCallback? callback) {
    if (callback == null) return null;
    return callback;
  }

  ButtonStyle? _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.blue,
      fixedSize: Size(MediaQuery.of(context).size.width, 55),
      foregroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isLoading ? null : _buttonState(widget.onPressed),
      style: _buttonStyle(),
      child: _buttonWidget(widget.isLoading),
    );
  }
}
