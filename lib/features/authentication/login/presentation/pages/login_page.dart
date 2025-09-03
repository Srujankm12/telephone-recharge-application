import 'package:flutter/material.dart';
import 'package:telephone_recharge_application/core/images/images.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/core/widgets/app_elevated_button.dart';
import 'package:telephone_recharge_application/core/widgets/app_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment(-1, 0),
                  child: Text(
                    "Welcome",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                Align(
                  alignment: Alignment(-1, 0),
                  child: Text(
                    "Card Telephone Recharge Application",
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: AppColors.grey),
                  ),
                ),
                SizedBox(height: 10),
                Image.asset(Images.loginPageImage, width: 280),
                SizedBox(height: 10),
                AppTextField(
                  hintText: "username",
                  icon: Icons.person,
                  controller: TextEditingController(),
                ),
                SizedBox(height: 20),
                AppTextField(
                  hintText: "password",
                  icon: Icons.password,
                  isPasswordField: true,
                  controller: TextEditingController(),
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment(0.9, 0),
                  child: Text(
                    "Forgot Password?",
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: AppColors.blue),
                  ),
                ),
                SizedBox(height: 20),
                AppElevatedButton(buttonText: "Login"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
