import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/core/images/images.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/features/authentication/login/presentation/cubit/auto_login_cubit.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    context.read<AutoLoginCubit>().autoLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AutoLoginCubit, AutoLoginState>(
      listener: (context, state) {
        if (state is AutoLoginSuccessState) {
          Navigator.pushReplacementNamed(context, "/devices");
        }
        if (state is AutoLoginFailureState) {
          Navigator.pushReplacementNamed(context, "/login");
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Images.companyLogo),
              SizedBox(height: 5),
              Text(
                "Vithsutra Technologies Pvt Ltd",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Telephone Card Recharge Application",
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: AppColors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
