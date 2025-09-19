import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephone_recharge_application/core/images/images.dart';
import 'package:telephone_recharge_application/core/theme/app_colors.dart';
import 'package:telephone_recharge_application/core/widgets/app_elevated_button.dart';
import 'package:telephone_recharge_application/core/widgets/app_snackbar.dart';
import 'package:telephone_recharge_application/core/widgets/app_text_field.dart';
import 'package:telephone_recharge_application/features/authentication/login/presentation/cubit/auto_login_cubit.dart';
import 'package:telephone_recharge_application/features/authentication/login/presentation/cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    context.read<AutoLoginCubit>().autoLogin();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _emailValidator(String? value) {
    String email = value?.trim() ?? '';
    if (email.isEmpty) {
      return 'Email is required';
    }
    final RegExp emailRegex = RegExp(
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
    );
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    String password = value?.trim() ?? '';
    if (password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'\d').hasMatch(password)) {
      return 'Password must contain at least one number';
    }
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              AppSnackbar.showSnackBar(state.message, context);
              Navigator.pushReplacementNamed(context, "/devices");
            }
            if (state is LoginFailureState) {
              AppSnackbar.showSnackBar(state.message, context);
            }
          },
        ),
        BlocListener<AutoLoginCubit, AutoLoginState>(
          listener: (context, state) {
            if (state is AutoLoginSuccessState) {
              Navigator.pushReplacementNamed(context, "/devices");
            }
          },
        ),
      ],
      child: Scaffold(
        body: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                      hintText: "Email",
                      icon: Icons.person,
                      controller: _emailController,
                      validator: _emailValidator,
                    ),
                    SizedBox(height: 20),
                    AppTextField(
                      hintText: "password",
                      icon: Icons.password,
                      isPasswordField: true,
                      controller: _passwordController,
                      validator: _passwordValidator,
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment(0.9, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/forgotPassword");
                        },
                        child: Text(
                          "Forgot Password?",
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: AppColors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return AppElevatedButton(
                          buttonText: "Login",
                          isLoading: state is LoginLoadingState,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<LoginCubit>(context).loginRequest(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
